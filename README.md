# Water-Quality

Decision Intelligence for Florida Water Safety Triage

## Description

This project supports water-safety triage for Florida bodies of water by helping decision owners identify which water samples may require intervention, further review, or normal monitoring. The capstone compares three decision-intelligence pathways: risk classification, priority triage, and review-band governance. The main analytic direction uses structured water-quality measurements such as pH, turbidity, dissolved oxygen, and conductivity to estimate whether a sample should be treated as lower risk or higher risk for human activity. The project is designed as a decision-support workflow rather than a stand-alone regulatory judgment tool. Its outputs are intended to help an environmental risk team screen cases faster, prioritize limited intervention capacity, and route borderline cases into review using explicit threshold and policy logic.

## Getting Started

### Dependencies

Before running the project, make sure the following are available:

* Windows 10 or later, or another operating system that supports R
* R version 4.x or later
* RStudio recommended
* Required R packages:

  * `ggplot2`
  * `pROC`
  * `dplyr`
  * `readr` or base R CSV loading
  * `iml` if local explainability plots are included
  * any additional package named in the scripts

### Installing

1. Download or copy the project folder to your local machine.
2. Place the dataset file in the project `data/` folder.
3. Confirm the dataset filename matches the filename expected by the scripts.
4. Open the project in RStudio or open the relevant `.R` scripts in R.

Recommended project structure:

```text
Water-Quality/
│
├── README.md
├── data/
│   └── Water_Quality_Testing.csv
├── scripts/
│   ├── 01_data_cleaning.R
│   ├── 02_modeling_classification.R
│   ├── 03_triage_policy.R
│   ├── 04_visualizations.R
│   └── 05_monitoring_checks.R
├── figures/
├── outputs/
└── memo/
```

If your local machine uses a different file path, update the file path in the script or set the working directory to the project folder before running.

### Executing program

Run the scripts in the order below:

1. Clean and prepare the data
2. Fit the classification model
3. Apply threshold, Top-K, and review-band policy logic
4. Generate visualizations and exhibits
5. Run monitoring or governance checks if included

Example workflow in R:

```r
source("scripts/01_data_cleaning.R")
source("scripts/02_modeling_classification.R")
source("scripts/03_triage_policy.R")
source("scripts/04_visualizations.R")
source("scripts/05_monitoring_checks.R")
```

If running manually inside RStudio, open each script and run them in sequence from top to bottom.

Main expected outputs include:

* scored water-sample dataset
* ROC / PR figure
* threshold or policy table
* Top-K prioritization table
* 3-band review policy exhibit
* monitoring or drift summary outputs

## Help

Common issues and fixes:

* **Dataset not found**

  * Make sure the CSV file is in the `data/` folder and that the filename matches the script.
* **Package not found**

  * Install the missing package with:

  ```r
  install.packages("package_name")
  ```
* **Object not found**

  * Run the scripts in the intended order so that cleaned data and model objects exist before later scripts call them.
* **Different local file paths**

  * Use relative file paths where possible, or update the CSV path in the script.

If the project fails during package loading, run:

```r
sessionInfo()
```

to confirm your R version and installed packages.

## Authors

Killian Williams
Decision Intelligence / Data Science Project

## Version History

* 0.3

  * Added capstone pathway structure, threshold logic, and governance notes
  * Organized project around classification, triage, and review-band policy
* 0.2

  * Added modeling and visualization workflow
  * Expanded threshold and monitoring outputs
* 0.1

  * Initial project setup and exploratory analysis

## License

This project is currently for academic use unless otherwise specified. Add a formal license before public distribution.

## Acknowledgments

* University of South Florida Decision Intelligence Studio materials
* Course slides and lab guidance on baselines, thresholds, governance, and monitoring
* README template inspiration from:

  * [awesome-readme](https://github.com/matiassingers/awesome-readme)
  * [PurpleBooth](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
  * [dbader](https://github.com/dbader/readme-template)
  * [zenorocha](https://gist.github.com/zenorocha/4526327)
  * [fvcproductions](https://gist.github.com/fvcproductions/1bfc2d4aecb01a834b46)
