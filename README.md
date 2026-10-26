# Shiny Gapminder Interactive Application

This repository contains the source code for an interactive web application built with **R Shiny** to explore global socioeconomic development metrics using the `gapminder` dataset.

## Live Application
You can interact with the deployed live web application directly in your browser here:  
👉 **[https://livine.shinyapps.io/InteractiveGapminder/](https://livine.shinyapps.io/InteractiveGapminder/)**

## Repository Structure
* **`app.R`**: The comprehensive application script containing the frontend layout configuration (`ui`) and the reactive backend data processing framework (`server`).

## Technical Highlights & Features

* **Slider Timeline Filter**: Allows step-by-step temporal data filtering across the dataset's target years using clean non-separated layout values.
* **Conditional Continental Filtering**: Includes a dropdown selector to subset observations across individual continents or evaluate global trends using an integrated `"All"` data option.
* **Custom Reactive Mapping**: Radio buttons allow mapping variables dynamically onto both X and Y coordinates between *Life Expectancy* (`lifeExp`), *Total Population* (`pop`), and *GDP per Capita* (`gdpPercap`).
* **Adaptive Logarithmic Scaling**: The server logic evaluates inputs on-the-fly and automatically overlays a logarithmic base-10 scale (`scale_x_log10()` / `scale_y_log10()`) whenever large metrics like population or GDP are requested to prevent data crowding.
* **Tailored Aesthetics**: Dots are explicitly sized according to population metrics (`scale_size(range = c(2, 18))`) and styled using a custom hex color system matching specific continental palettes.


