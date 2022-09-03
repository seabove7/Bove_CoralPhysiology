# *[Global change differentially modulates Caribbean coral physiology](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0273897)*

<p align="center">
<img src="https://user-images.githubusercontent.com/45176386/125361215-0320f800-e33b-11eb-9d81-72ebf66590e2.jpg" width = "500" />
</p>

**Authors:** Colleen B Bove, Sarah W Davies, Justin B Ries, James Umbanhowar, Bailey C Thomasson, Elizabeth B Farquhar, Jessica A McCoppin, and Karl D Castillo

**Abstract:**  
Global change driven by anthropogenic carbon emissions is altering ecosystems at unprecedented rates, especially coral reefs, whose symbiosis with algal symbionts is particularly vulnerable to increasing ocean temperatures and altered carbonate chemistry. Here, we assess the physiological responses of three Caribbean coral (animal host + algal symbiont) species from an inshore and offshore reef environment after exposure to simulated ocean warming (28, 31°C), acidification (300–3290 μatm), and the combination of stressors for 93 days. We used multidimensional analyses to assess how a variety of coral physiological parameters respond to ocean acidification and warming. Our results demonstrate reductions in coral health in *Siderastrea siderea* and *Porites astreoides* in response to projected ocean acidification, while future warming elicited severe declines in *Pseudodiploria strigosa*. Offshore *S. siderea* fragments exhibited higher physiological plasticity than inshore counterparts, suggesting that this offshore population was more susceptible to changing conditions. There were no plasticity differences in *P. strigosa* and *P. astreoides* between natal reef environments, however, temperature evoked stronger responses in both species. Interestingly, while each species exhibited unique physiological responses to ocean acidification and warming, when data from all three species are modelled together, convergent stress responses to these conditions are observed, highlighting the overall sensitivities of tropical corals to these stressors. Our results demonstrate that while ocean warming is a severe acute stressor that will have dire consequences for coral reefs globally, chronic exposure to acidification may also impact coral physiology to a greater extent in some species than previously assumed. Further, our study identifies *S. siderea* and *P. astreoides* as potential ‘winners’ on future Caribbean coral reefs due to their resilience under projected global change stressors, while *P. strigosa* will likely be a ‘loser’ due to their sensitivity to thermal stress events. Together, these species-specific responses to global change we observe will likely manifest in altered Caribbean reef assemblages in the future.

<br/>

**Citation:**  **Bove CB**, Davies SW, Ries JB, Umbanhowar J, Thomasson BC, Farquhar EB, McCoppin JA, Castillo KD. Global change differentially modulates coral physiology and suggests future shifts in Caribbean reef assemblages. *PLOS ONE*, DOI: [10.1371/journal.pone.0273897](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0273897)

**Zenodo DOI:** [10.5281/zenodo.5093907](https://doi.org/10.5281/zenodo.5093907)

[![DOI](https://zenodo.org/badge/209146824.svg)](https://zenodo.org/badge/latestdoi/209146824)

---

#### Repository contains the following:
1. R markdown script and html output with all code and analyses included in manuscript (*OA_OW_Physiology_manuscript*)
2. [Data](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Data)
   * [Raw_data](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Data/Raw_data)
      * All coral holobiont physiology data and experimental conditions used in analyses (*phys_all_23March2021.csv*)
      * Net calcification rates reported previously for these samples in [Bove et al 2019](https://github.com/seabove7/proc-b-2019) (*net_calc.csv*)
   * [Supplemental](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Data/Supplemental)
      * Supplemental tables as an excel file produced in the markdown file (*Supplemental_Tables.xlsx*)
   * [Bootstrap](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Data)
      * *P. astreoides* model mean/CI of plasticity (*PAST_PlastBoot.rda*)
      * *P. strigosa* model mean/CI of plasticity (*PSTR_PlastBoot.rda*)
      * *S. siderea* model mean/CI of plasticity (*SSID_PlastBoot.rda*)
      * Host versus symbiont model mean/CI plasticity (*HostVSymb_PlastBoot.rda*)
3. [Figures](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Figures)
   * [Final_Figures](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Figures/Final_Figures)
      * Figure1_PhysPCA (*PNG and PDF versions*)
      * Figure2_PhysCorrelations (*PNG and PDF versions*)      
      * Figure3_PhysPlasticity (*PNG and PDF versions*)
      * Figure4_SpeciesPCA (*PNG and PDF versions*)
   * [Supplemental](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Figures/Supplemental_Figures)
      * FigureS1_PhysPCA_RZ (*PNG and PDF versions*)
      * FigureS2_SSID_PCA_hostVsymb (*PNG and PDF versions*)
      * FigureS3_PSTR_PCA_hostVsymb (*PNG and PDF versions*)
      * FigureS4_PAST_PCA_hostVsymb (*PNG and PDF versions*)
      * FigureS5_hostVsymb_plasticity (*PNG and PDF versions*)
      * FigureS6_AllPhysiology (*PNG and PDF versions*)
      * FigureS7_BleachingImages (*PNG only*)
      * FigureS8_speciesPCA_reef (*PNG and PDF versions*)
      * PAST_PhysCorrelations (*used in creation of main Figure 2*)
      * PSTR_PhysCorrelations (*used in creation of main Figure 2*)
      * SSID_PhysCorrelations (*used in creation of main Figure 2*)
3. [Code](https://github.com/seabove7/Bove_CoralPhysiology/tree/master/Code)
   * R script containing custom functions needed for Rmarkdown code (*CustomFunctions.R*)
   * Custom python script used for white correction of photos for colour analysis (Written by [Matthew Kendall](https://github.com/matt-kendall)) (*whiteCorrection.py*)
   * MATLAB Macros required for the colour intensity analysis used here that was modified from [Winters et al 2009](https://www.tau.ac.il/lifesci/departments/zoology/members/loya/documents/206Winters.pdf) (*Macros folder*)
   * README with instructions for use of the whiteCorrection.py script and protocol for colour correction (*README.md*)

---

#### Protocols for [Carbohydrate](dx.doi.org/10.17504/protocols.io.bvb9n2r6) and [Lipid](dx.doi.org/10.17504/protocols.io.bvcfn2tn) assays can be accessed on [protocols.io](protocols.io).
