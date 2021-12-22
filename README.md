# MOpenWrt Firmwares

Build The OpenWrt firmwares [Lean's OpenWrt](https://github.com/coolsnowwolf/lede) using GitHub Actions

* NanoPi R2S
* NanoPi R4S
* OrangePi R1 plus
* Netgear WNDR4300v1
* Linksys WRT1900ACv2

## Usage

Install crudini first: `apt install crudini`

1. Checkout the repo itself.
2. Clone Openwrt Source: the default is https://github.com/coolsnowwolf/lede#master
3. Load custom feeds(`diy-part1.sh`)
4. Update feeds
5. Install feeds
6. Load custom configuration(`diy-part2.sh`)
7. SSH connection to Actions
8. Download packages
9. Compile the firmware
10. Upload bin directory
11. Upload firmware directory
12. Upload firmware to cowtransfer
13. Upload firmware to WeTransfer
14. Generate release tag
15. Upload firmware to release


## Profiles

Directory Structure:

```
devices
├── common                          # Default profile settings
│   ├── ...
│   └── settings.ini                # Github Action Settings
├── target1                         # First target
│   ├── .config                     # From .config
│   ├── diy.sh                   # Scripts to be executed before compiling
│   ├── files                       # Files to be copied to OpenWrt buildroot dir, arranged in same structure
│   │   └── somefile
│   └── settings.ini                # Settings
└── target2
    ├── .config
    ├── diy.sh
    ├── packages.txt
    ├── patches                     # Patches to be applied onto OpenWrt buildroot dir
    │   └── 001-somepatch.patch
    └── settings.ini
```

## Credits

- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cowtransfer](https://cowtransfer.com)
- [WeTransfer](https://wetransfer.com/)
- [Mikubill/transfer](https://github.com/Mikubill/transfer)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [ActionsRML/delete-workflow-runs](https://github.com/ActionsRML/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)
- [peter-evans/repository-dispatch](https://github.com/peter-evans/repository-dispatch)
- [Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt/)
- [DHDAXCW/NanoPi-R4S-2021](https://github.com/DHDAXCW/NanoPi-R4S-2021)

## License

MIT
