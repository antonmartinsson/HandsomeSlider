# ``HandsomeSliderKit``

A work in progress Swift Package enabling seamless creation of segmented horizontal sliders. 

## Getting Started

Using HandsomeSlider should be a piece of cake for most developers. 
Let's say you want to display a slider which lets your users select a percentage for a tip. 

```swift
struct TippingView: View {
  let tipOptions: [SliderOption]
  @State var selectedTip: SliderOption?

  var body: some View {
    VStack {
      HandsomeSlider(sliderOptions: tipOptions, initialSelection: selectedTip)
      Button {
        // Trigger logic for tipping
      } label: {
        Label {
          Text("Tip")
        } icon: {
          Image(systemName: "creditcard")
        }
      }
    }
  }
}
```

The selectable options you provide to the `HandsomeSlider` are called `SliderOption`s. 
In the above example, `tipOptions` could be an array that looks something like this:

```swift
let fivePercent = SliderOption(id: "five", title: "5%")
let tenPercent = SliderOption(id: "ten", title: "10%")
let fifteenPercent = SliderOption(id: "fifteen", title: "15%")
let twentyPercent = SliderOption(id: "twenty", title: "20%")

let tipOptions = [fivePercent, tenPercent, fifteenPercent, twentyPercent]
```

The resulting view will look something like this:

![SliderExample](https://github.com/antonmartinsson/HandsomeSlider/blob/main/Sources/HandsomeSliderKit/HandsomeSliderKit.docc/Resources/SliderExample.png)

Should you want to customize the color scheme of the slider, you can do so by passing an instance of `HandsomeColorScheme` into the `HandsomeSlider`'s init.

```swift
let backgroundColor: Color = .accentColor.opacity(0.2)
let dotColor: Color = .white.opacity(0.8)
let indicatorColor: Color = .accentColor
let colorScheme = HandsomeColorScheme(background: backgroundColor, dots: dotColor, indicator: indicatorColor)

HandsomeSlider(sliderOptions: tipOptions, initialSelection: selectedTip, colorScheme: colorScheme)
```

Please note that more customization options are planned for future releases. In the meantime, I hope you enjoy using HandsomeSlider! 
