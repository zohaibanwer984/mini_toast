## 1.2.0
### ✨ New Features
* Added Web Platform Support
  - Full compatibility with web browsers
  - Optimized rendering for web environment
  - Consistent behavior across platforms
* Implemented Toast Dismissal
  - Users can now manually dismiss toasts by clicking/tapping
  - Automatic cleanup of dismissed toast resources
  - Optional dismiss callback for custom handling

### 🐛 Bug Fixes
* Improved toast positioning in web browsers
* Fixed overlay issues in web context

### 📝 Documentation
* Added web platform setup instructions
* Updated example code with dismiss functionality

## 1.1.0
### ✨ New Features
* Added Warning Variant
  - New orange-colored warning toast type
  - Warning icon (`warning_amber_outlined`)
  - Consistent styling with existing variants
* Implemented Custom Toast Widget Support
  - New `showCustom` method for displaying custom widgets
  - Full control over toast content and styling
  - Maintains animation and positioning features
  - Example implementations added to documentation

### 💡 Improvements
* Enhanced type safety for custom toast implementations
* Improved documentation with custom toast examples

## 1.0.0
### 🎉 Initial Release
* Core Features
  - Dynamic toast notifications with auto-positioning
  - Three base variants: success, error, and info
  - Built-in Material Design icons
  - Automatic size adjustment
  - Queue management system

* Customization Options
  - Flexible positioning (top, bottom, left, center, right)
  - Animation control
    - Configurable durations
    - Smooth slide animations
    - Fade effects
  - Appearance customization
    - Text styles
    - Icon colors
    - Margins and padding
    - Border radius
    - Shadow effects
    - Toast spacing

* Developer Experience
  - Simple singleton API via `MiniToast.instance`
  - Comprehensive documentation
  - Example application
  - Type-safe API

### 📝 Notes
- Requires Flutter SDK 3.10.0 or higher
- Supports null safety