# Mac Battery Inspector

[![GitHub license](https://img.shields.io/github/license/5j54d93/Mac-Battery-Inspector)](https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/LICENSE)
![GitHub Repo stars](https://img.shields.io/github/stars/5j54d93/Mac-Battery-Inspector)
![GitHub repo size](https://img.shields.io/github/repo-size/5j54d93/Mac-Battery-Inspector)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey)

A macOS app develop with SwiftUI in MVVM that could inspect many mac's battery info.

<img src="https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/.github/Assets/main.png" width='100%' height='100%'/>

## Overview

1. [**HighLight**](https://github.com/5j54d93/Mac-Battery-Inspector#highlight)
2. [**Screen Saver**](https://github.com/5j54d93/Mac-Battery-Inspector#screen-saver)
3. [**Row Data**](https://github.com/5j54d93/Mac-Battery-Inspector#row-data)
4. [**MenuBarExtra**](https://github.com/5j54d93/Mac-Battery-Inspector#menubarextra)
5. [**Dark Mode**](https://github.com/5j54d93/Mac-Battery-Inspector#dark-mode)
6. [**License**](https://github.com/5j54d93/Mac-Battery-Inspector#licensemit)

## HighLight

Main View highlights some important information of mac's battery. Including：
- **Temperature**：in Celsius
- **Time Remaining**：time to fully charge or time to run out
- **Adapter Detail**：some important information of power adapter
- **Battery**：Remain percentage
- **Cycle Count**：max cycle count for a battery life is 1000
- **Battery Health**

When mac is start/stop charging, HighLight view will show/hide adapter detail with animation.

<img src="https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/.github/Assets/MainDemo.gif" width='100%' height='100%'/>

## Screen Saver

A view includes 100 blocks to represent current capacity.

## Row Data

This view shows all data from `IOPSCopyPowerSourcesInfo` and `AppleSmartBattery` without doing any transformation.

<img src="https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/.github/Assets/RowData.png" width='100%' height='100%'/>

And this page also support searching. Search result will highlight what user search in geeen.

<img src="https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/.github/Assets/SearchResult.png" width='100%' height='100%'/>

## MenuBarExtra

MenuBarExtra will always appear on top right of mac's menu bar unless "Mac Battery Inspector" is been quited. 

<img src="https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/.github/Assets/MenuBarExtra.png" width='100%' height='100%'/>

## Dark Mode

"Mac Battery Inspector" also support dark mode！User could select mode on top right of tool bar for "Mac Battery Inspector" to follow system's preference or user's preference.

<img src="https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/.github/Assets/DarkMode.png" width='100%' height='100%'/>

## License：MIT

This package is [MIT licensed](https://github.com/5j54d93/Mac-Battery-Inspector/blob/main/LICENSE).
