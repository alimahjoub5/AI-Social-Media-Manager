# AI Social Media Manager

A **UiPath automation project** that explores how RPA and AI can work together to automate parts of a social-media content pipeline.

The project separates trend discovery, content generation, and image generation into reusable workflows coordinated by a main process.

## Workflow

```text
Trend discovery
      ↓
AI-assisted content generation
      ↓
Image generation
      ↓
Prepared social-media assets
```

## Main Workflows

| Workflow | Responsibility |
|---|---|
| `Main.xaml` | Coordinates the automation |
| `WF01_Get_Trends.xaml` | Identifies trending topics or keywords |
| `WF02_Generate_Content.xaml` | Generates text content from the selected trends |
| `WF03_GenerateImages.xaml` | Generates supporting images for the content |

## Repository Structure

```text
.
├── Main.xaml
├── Workflows/
├── Config/
├── Data/
├── Images/
├── project.json
└── project.uiproj
```

## What This Project Demonstrates

- UiPath workflow orchestration
- Breaking an automation into reusable components
- AI-assisted content workflows
- Configuration- and data-oriented project organization
- Combining RPA with generative-AI use cases

## Technology

- **UiPath Studio**
- **XAML workflows**
- **Visual Basic expressions**
- **AI-assisted automation concepts**

## Getting Started

1. Clone or download the repository.
2. Open the project in UiPath Studio.
3. Restore the dependencies defined in `project.json`.
4. Review the configuration and workflow files.
5. Configure any external services or credentials required by your environment.
6. Run `Main.xaml`.

## Purpose

This project is a portfolio and learning project focused on **intelligent automation**: using UiPath as the orchestration layer around AI-driven content-generation tasks.
