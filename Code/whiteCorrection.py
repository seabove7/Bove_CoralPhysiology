import logging
import os

from PIL import Image


IMAGE_FILE_EXTENSIONS = ['.bmp', '.gif', '.jpeg', '.jpg', '.png', '.tiff']
OUTPUT_DIR_NAME = 'out'
DEBUG_DIR_NAME = 'debug'
LOGFILE_NAME = 'adjust.log'


def main():
    logging.basicConfig(filename=LOGFILE_NAME, level=logging.DEBUG, format='%(asctime)s %(message)s')
    logging.info("Looking for images...")
    base_dir = '.'
    target_coords = 3750, 2900 #  [3850, 3050, 3950, 3150, 3900, 3100, 3000, 3050]
    radius = 50    

    prep_output_dir(base_dir)

    all_files = [f for f in os.walk(base_dir)][0][2]
    files_to_process = [f for f in all_files if is_image(f)]
    
    num_files = len(files_to_process)
    logging.info("Found %d image files to process.", num_files)
    i = 0
    for filename in files_to_process:
        logging.info("Adjusting image %s (%d/%d)." % (filename, i + 1, num_files))
        img = Image.open(filename)
        img = img.convert('RGB')
        adjusted_img = adjust_image(img, target_coords, radius, filename)
        adjusted_img.save(os.path.join(OUTPUT_DIR_NAME, filename))#, subsampling=0, quality=100)
        i += 1

    
"""
Determine if a filename is an image to be processed, based on the filename. 
"""
def is_image(filename):
    for ext in IMAGE_FILE_EXTENSIONS:
        if filename.lower().endswith(ext):
            return True
    return False


"""
Make sure the output directory exists.
"""
def prep_output_dir(base_dir):    
    output_dir = os.path.join(base_dir, OUTPUT_DIR_NAME)
    debug_dir = os.path.join(base_dir, DEBUG_DIR_NAME)
    logging.info("Making output directory %s" % output_dir)
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    logging.info("Making debug directory %s" % debug_dir)
    if not os.path.exists(debug_dir):
        os.makedirs(debug_dir)


"""
Perform the adjustment on a given image.
"""
def adjust_image(image, target_coords, radius, fn):
    r, g, b = get_image_sample_color(image, target_coords, radius, fn)
    logging.debug("Image sample color is rgb(%d, %d, %d)." % (r, g, b))   
    
    # check for r,g,b = 0
    scale_r = 255.0 / r
    scale_g = 255.0 / g
    scale_b = 255.0 / b
   
    # m = max((sr,sg,sb))
    # sr = m
    # sg = m
    # sb = m

    cr, cg, cb = image.split()
    cr = cr.point(lambda i: i * scale_r)
    cg = cg.point(lambda i: i * scale_g)
    cb = cb.point(lambda i: i * scale_b)

    out = Image.merge('RGB', (cr, cg, cb))
    return out
    
def get_image_sample_color(image, target_coords, radius, fn):
    #return 195, 191, 179
    tx, ty = target_coords
    sub = image.crop([tx - radius, ty - radius, tx + radius, ty + radius])
    sub.save(os.path.join(DEBUG_DIR_NAME, fn))
    small = sub.resize([1,1], Image.BILINEAR)
    r,g,b = small.getpixel((0,0))
    return r,g,b


if __name__ == '__main__':
    main()





# basedir = '/home/matt/coll-photos/'
# files = ['CFSE1.JPG', 'CFSE3.JPG', 'CFSE5.JPG', 'CFSE6.JPG', 'CFSE7.JPG', 'CFSE8.JPG', 'CFSE11.JPG']

# for f in files:
#     fn = basedir + f
#     im = Image.open(f)
#     # l, u, r, d
#     sub = im.crop([3850, 3050, 3950, 3150])
#     sub.save('debug/' + f)
#     small = sub.resize([1,1])
#     r,g,b = small.getpixel((0,0))

#     sr = 255 / r
#     sg = 255 / g
#     sb = 255 / b
#     # print(r,g,b)
#     # print(sr, sg, sb)

#     # m = max((sr,sg,sb))
#     # sr = m
#     # sg = m
#     # sb = m

#     cr, cg, cb = im.split()
#     cr = cr.point(lambda i: i * sr)
#     cg = cg.point(lambda i: i * sg)
#     cb = cb.point(lambda i: i * sb)

#     out = Image.merge('RGB', (cr, cg, cb))
#     out.save('out/'+ f + '_python.jpg')

