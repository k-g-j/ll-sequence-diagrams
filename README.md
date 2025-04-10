# LayerLens Sequence Diagrams

Architecture and sequence diagrams for the LayerLens project.

## Viewing Diagrams

The diagrams can be viewed in several ways:

1. **Interactive HTML Viewer**: Open `index.html` in any browser to view the diagrams with tabs for each system.
   - Click on any diagram to zoom in and examine details
   - Use mouse drag or touch to pan the image when zoomed in
   - Use mouse wheel or pinch gestures to zoom in/out
2. **Markdown Files**:
   - [Atlas App Sequence Diagrams](atlas-app-sequence-diagram.md)
   - [Evaluation AVS Sequence Diagrams](evaluation-avs-sequence-diagram.md)
3. **Raw Files**: Find individual diagram files in the `custom-diagrams/v4` directory.

## View Online

View these diagrams rendered online at:
https://k-g-j.github.io/ll-sequence-diagrams/

GitHub repository:
https://github.com/k-g-j/ll-sequence-diagrams

## Diagram Types

### Atlas App
1. User Authentication Flow
2. Evaluation Creation and Processing Flow
3. Dataset Management Flow
4. Results Viewing and Comparison Flow
5. Complete System Architecture

### Evaluation AVS
1. Task Creation and Assignment Flow
2. Operator Registration Flow
3. Task Reassignment Flow
4. Complete System Architecture

## Generating/Updating Diagrams

The diagrams are created using PlantUML. To update them:

1. Edit the source files in the `plantuml-diagrams` directory
2. Run the generation script:
   ```
   chmod +x generate_diagrams.sh
   ./generate_diagrams.sh
   ```

## Requirements for Diagram Generation

- Java (for running PlantUML)
- ImageMagick (optional, for resizing large diagrams)

The `generate_diagrams.sh` script will download PlantUML JAR if not present.

## Styling Conventions

All sequence diagrams use these PlantUML settings for consistent styling:

```
skinparam monochrome true
skinparam handwritten false
skinparam shadowing false
skinparam defaultFontName Arial
skinparam sequenceMessageAlign center
skinparam linetype polyline
```

Architecture diagrams use the C4 model notation for clear component visualization.