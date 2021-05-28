# Hackintosh

This is the guide for **OpenCore 0.6.9** with **Big Sur 11.4** for an **iMac19,2** hackintosh build.

**Please read** the [OpenCore Guide](https://dortania.github.io/OpenCore-Install-Guide/) to **understand the process** and make any changes if you require different settings.

## Why use iMac 19,2 model?
- Native **Intel Cofee Lake** power management;
- **AMD GPU** and **iGPU** for balanced performance;
- **h264** and **h265** video **encoding** and **decoding** working;
- **Sidecar** working because **this iMac do not have T2 chip**;
- Note that are DRM issues with **Netflix**, **PrimeVideo** and **Apple TV+** in Big Sur until community finds a solution _(if you require DRM support, better use the iMacPro1,1 or MacPro7,1 SMBIOS and read this until the end for more information)_.

## Hardware

This is the parts list:

- **CPU:** [Intel i7 8700 ](https://www.intel.com.br/content/www/br/pt/products/processors/core/core-vpro/i7-8700.html) 8th generation 6 cores and 12 threads 3,2GHz with Turbo Boost up to 4,6GHz
- **Motherboard:** [Gigabyte Z370N WiFi 1.0 ](https://www.gigabyte.com/br/Motherboard/Z370N-WIFI-rev-10#kf) Mini ITX
- **RAM:** [G.SKILL 32GB ](https://www.gskill.com/product/165/326/1562838932/F4-3200C16D-32GTZN-Overview) DDR4 3200MHz F4-3200C16D-32GTZN
- **SSD:** [Samsung EVO 970 Plus ](https://www.samsung.com/semiconductor/minisite/ssd/product/consumer/970evoplus/) 250GB PCIe NVMe
- **Power Supply:** [Corsair CX550 Bronze ](https://www.corsair.com/br/pt/Categorias/Produtos/Unidades-de-fonte-de-alimentação/cx-series-config/p/CP-9020121-WW) 550W Unit
- **GPU:** [Gigabyte Radeon RX 590 8GB 1.0](https://www.gigabyte.com/br/Graphics-Card/GV-RX590GAMING-8GD-rev-10#kf) Dedicated Video Card
- **Wireless:** [BCM94360NG ](http://en.fenvi.com/en/download_zx.php) Bluetooth and WiFI replacement card
- **Case:** [XIGMATEK Nebula C ](https://www.xigmatek.com/product_detail.php?item=63) Mini ITX

### Gigabyte Z370N WiFi BIOS F14b settings

- **Load optimised defaults**
- MIT &gt; Advanced Memory Settings &gt; XMP &gt; **Profile 1**
- SmartFan &gt; Fan Control Mode &gt; **PWM**
- SmartFan &gt; Fan Stop &gt; **ENABLED**
- BIOS &gt; CSM Support &gt; **DISABLED**
- BIOS &gt; Windows 8/10 Features &gt; **Windows 8/10 WHQL**
- Peripherals &gt; Above 4G Decoding &gt; **ENABLED**
- Peripherals &gt; Re-Size Bar &gt; **DISABLED**
- Peripherals &gt; Intel PTT &gt; **ENABLED**
- Peripherals &gt; SGX &gt; **Software Controlled**
- Peripherals &gt; Trusted Computing &gt; **ENABLED**
- Peripherals &gt; USB Config &gt; Legacy &gt; **DISABLED**
- Peripherals &gt; USB Config &gt; XHCI Handoff &gt; **ENABLED**
- Chipset &gt; VT-d &gt; **DISABLED**
- Chipset &gt; Internal Graphics &gt; **ENABLED** with min **64MB** and **MAX**; 
- Chipset &gt; Wake On Lan &gt; **DISABLED** _(disable on adapters too)_
- Power &gt; ErP &gt; **ENABLED**
- Save and restart

## Windows 10

- If you plan to have Windows setup, it must be **installed first** on it's own disk;
- Use your **motherboard and AMD drivers** supplied. For **WIFI/Bluetooth** drivers, [download](http://en.fenvi.com/en/download_zx.php) from Fenvi.

## MacOS 11 Big Sur

- Can be direct downloaded from Apple using [App Store](https://apps.apple.com/br/app/macos-big-sur/id1526878132?mt=12) on a regular MacOS computer; 
- Make a **USB** install disk _(the example below uses a USB device named USB and makes Big Sur installation disk)_:
```bash
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/USB
```
- Use [git repo](https://github.com/elieserme/hackintosh/) to download the **EFI** folder 

```bash
git clone git@github.com:elieserme/hackintosh.git
```

Use [ProperTree](https://github.com/corpnewt/ProperTree) to edit the **config.plist** file and change **PlatformInfo** values to your own machine:
- **MLB**, **SystemSerialNumber** and **SystemUUID** can be generated by [GenSMBIOS utility](https://github.com/corpnewt/GenSMBIOS);
- Before use a generated **SystemSerialNumber**, check it on [Apple Database](https://checkcoverage.apple.com) _(If it is valid, generate another and repeat if necessary until find an invalid and unused one)_; 
- **ROM** is the Mac address of the **en0** network adapter _(on Gigabyte z370N WIFI 1.0 is the Intel i219v gigabit port)_. Use the **Network Settings > Advanced > Hardware** panel to copy the Mac address _(only numbers and letters, without the : chars)_;
- Inside the **config.plist** search and replace **AAAAAAAAAAAA** with your generated _SystemSerialNumber_ value, **BBBBBBBBBBBBBBBBBB** with _MLB_ value, **CCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC** with _SystemUUID_ value and **DDDDDDDD** with _ROM_ value:
```xml
<key>PlatformInfo</key>
<dict>
	<key>Automatic</key>
	<true/>
	<key>CustomMemory</key>
	<false/>
	<key>Generic</key>
	<dict>
		<key>MaxBIOSVersion</key>
		<false/>
		<key>AdviseWindows</key>
		<false/>
		<key>SystemMemoryStatus</key>
		<string>Auto</string>
		<key>MLB</key>
		<string>BBBBBBBBBBBBBBBBBB</string>
		<key>ProcessorType</key>
		<integer>0</integer>
		<key>ROM</key>
		<data>DDDDDDDD</data>
		<key>SpoofVendor</key>
		<true/>
		<key>SystemProductName</key>
		<string>iMac19,2</string>
		<key>SystemSerialNumber</key>
		<string>AAAAAAAAAAAA</string>
		<key>SystemUUID</key>
		<string>CCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC</string>
	</dict>
	<key>UpdateDataHub</key>
	<true/>
	<key>UpdateNVRAM</key>
	<true/>
	<key>UpdateSMBIOS</key>
	<true/>
	<key>UpdateSMBIOSMode</key>
	<string>Create</string>
	<key>UseRawUuidEncoding</key>
	<false/>
</dict>
```

- Mount the **EFI partition** of the **USB** disk using [MountEFI](https://github.com/corpnewt/MountEFI) utility and **copy the EFI folder** inside **/Volumes/EFI**
- **Boot** the target machine with **USB** disk you just made
- Using **Modified GRUB Shell** we must disable **CFG Lock** first with command below, but **note that hardcoded value is for F14a/b BIOS version of the Gigabyte z370N WIFI 1.0 motherboard, if you use another BIOS version or another motherboard model you need to recalculate this value** _(this command must run every time that BIOS is reflashed or CMOS clear. Please note that some other motherboards can disable CFG Lock on BIOS settings without this hack)_
```bash
setup_var_3 0x5A4 0x00
```
- Use **Clear NVRAM** and reboot to make a clean install
- Use **Disk Utility** to erase a **APFS GUI** volume and **install MacOS**
- Finish **normal** MacOS setup
- Install **App Store** applications, including **Xcode**
- Install [HomeBrew ](https://brew.sh) package management tool and run the **Scripts** for install tools _(can skip this step if you don't plan to use development tools)_
- System Preferences &gt; Software Updates &gt; **Uncheck**
- System Preferences &gt; General &gt; Show Scrollbars &gt; **When scrolling**
- System Preferences &gt; Notifications &gt; **Check disable between 22h and 7h**
- System Preferences &gt; Monitors &gt; NightShift &gt; **Sunset to Sunrise**
- System Preferences &gt; Security &gt; Privacy &gt; **Check system locations service**
- System Preferences &gt; Security &gt; **activate Filevalt**
- Finder &gt; Preferences &gt; Start in **Documents** folder
- Finder &gt; Preferences &gt; Show **Home Folder**
- Finder &gt; View &gt; Show **Status Bar**
- Desktop &gt; Right click &gt; **Use Stacks**

## Post install

### Windows and Bootcamp

- If you don't plan to install BootCamp drivers, you need patch registry for **time sync** with MacOS, run **regedit as Administrator** and go to HKEY_LOCAL_MACHINE &gt; SYSTEM &gt; CURRENTCONTROLSET &gt; CONTROL &gt; TIMEZONEINFORMATION and add the property **RealTimeIsUniversal** with value **DWORD=1**
- Or you can install **BootCamp** drivers with [Brigadier](https://github.com/timsutton/brigadier) utility after MacOS installed _(use this option if you plan to use Apple Magic Keyboard and Trackpad)_
```bash
git clone https://github.com/timsutton/brigadier
cd brigadier
brigadier -m iMac19,2 -i
```
### Cleaning the EFI

- Remove all **Tools** from menu _(if you need this tools again you can use your USB disk to boot)_. Edit your **config.plist** and find the following section and disable:
```diff
	<key>Tools</key>
	<array>
		<dict>
			<key>Comment</key>
			<string>OpenShell.efi<string>
			<key>Auxiliary</key>
			<true/>
			<key>Enabled</key>
-			<true/>
+			<false/>
			<key>Arguments</key>
			<string></string>
			<key>Path</key>
			<string>OpenShell.efi<string>
			<key>Name</key>
			<string>OpenShell.efi<string>
			<key>RealPath</key>
			<false/>
			<key>TextMode</key>
			<false/>
		</dict>
		<dict>
			<key>Comment</key>
			<string>modGRUBShell.efi<string>
			<key>Auxiliary</key>
			<true/>
			<key>Enabled</key>
-			<true/>
+			<false/>
			<key>Arguments</key>
			<string></string>
			<key>Path</key>
			<string>modGRUBShell.efi<string>
			<key>Name</key>
			<string>modGRUBShell.efi<string>
			<key>RealPath</key>
			<false/>
			<key>TextMode</key>
			<false/>
		</dict>
	</array>
```
- Disable **Reset NVRAM** option too:
```diff
	<key>AllowNvramReset</key>
-	<true/>
+	<false/>
```
- Disable **Boot Menu** to work like a real Mac:
```diff
	<key>ShowPicker</key>
-	<true/>
+	<false/>
```

## Notes 

After all you will can boot MacOS, Windows and Recovery **just like a real Mac** computer:
- Hold **Option** key (or **ESC** key) to show boot menu;
- Use **System Preferences > Startup** disk to change boot to Windows and **BootCamp Control Panel** on Windows to change the boot to Mac;
- Update your Mac using the **Apple Software Updates**;
- Remind [update OpenCore](https://dortania.github.io/OpenCore-Post-Install/universal/update.html) **before** update MacOS.

## Other SMBIOS

### iMacPro1,1

Use the MacPro1,1 SMBIOS if you **require full DRM support**. Follow the steps below:
- **Disable iGPU** in **BIOS** settings, changing **Chipset &gt; Internal Graphics** to **DISABLED** 
- Change **config.plist** and replace **SystemProductName** with iMacPro1,1:
```diff
	<key>SystemProductName</key>
-	<string>iMac19,2</string>
+	<string>iMacPro1,1</string>
```
- Generate a new **MLB**, **SystemSerialNumber** and **SystemUUID** for iMacPro1,1 using [GenSMBIOS utility](https://github.com/corpnewt/GenSMBIOS) and **replace this values** in your **config.plist**;
- **Remove this section** from your **config.plist** since you **don't have iGPU** anymore:
```diff
-	<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
-	<dict>
-		<key>AAPL,ig-platform-id</key>
-		<data>AwCSPg==</data>
-	</dict>
```
- Find and Enable **XHC1 to SHCI** patch in your **config.plist**:
```diff
	<key>Patch</key>
	<array>
		<dict>
			<key>Comment</key>
			<string>XHC1 to SHCI</string>
			<key>Count</key>
			<integer>0</integer>
			<key>Enabled</key>
-			<false/>
+			<true/>
			<key>Find</key>
			<data>WEhDMQ==</data>
			<key>Limit</key>
			<integer>0</integer>
			<key>Mask</key>
			<data></data>
			<key>OemTableId</key>
			<data></data>
			<key>Replace</key>
			<data>U0hDSQ==</data>
			<key>ReplaceMask</key>
			<data></data>
			<key>Skip</key>
			<integer>0</integer>
			<key>TableLength</key>
			<integer>0</integer>
			<key>TableSignature</key>
			<data></data>
		</dict>
	</array>
```
- Edit **USBPorts.kext** _(on Mac you need to right click and Show Package Contents, edit info.plist inside de Contents folder)_ and change in **two places** the new SMBIOS:
```diff
	<key>IOKitPersonalities</key>
	<dict>
-	<key>iMac19,2-XHC</key>
+	<key>iMacPro1,1-XHC</key>
```
and
```diff
	<key>model</key>
-	<string>iMac19,2</string>
+	<string>iMacPro1,1</string>
```
- **Copy** the files **CPUFriend.kext** and **CPUFriendDataProvider.kext** from folder **other/imapro11** in this repo to your **Kexts** folder
- **Enable** the **CPUFriend.kext** and **CPUFriendDataProvider.kext** and in your **config.plist** _(this kexts are supplied but disabled by default)_:
```diff
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
-		<false/>
+		<true/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string>Contents/MacOS/CPUFriend</string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>CPUFriend.kext</string>
	</dict>
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
-		<false/>
+		<true/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string></string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>CPUFriendDataProvider.kext</string>
	</dict>
```
- Remind to **Reset NVRAM** if you are changing from iMac19,2 running to new iMacPro1,1 **prior to reboot MacOS** _(if you need to generate your own CPUFriendDataProvider.kext see the apendix below for instructions)_

### MacPro7,1

Use the MacPro7,1 SMBIOS if you **require full DRM support** and **best video production** acceleration. Follow the steps below:
- **Disable iGPU** in **BIOS** settings, changing **Chipset &gt; Internal Graphics** to **DISABLED** 
- Change **config.plist** and replace **SystemProductName** with MacPro7,1:
```diff
	<key>SystemProductName</key>
-	<string>iMac19,2</string>
+	<string>MacPro7,1</string>
```
- Generate a new **MLB**, **SystemSerialNumber** and **SystemUUID** for MacPro7,1 using [GenSMBIOS utility](https://github.com/corpnewt/GenSMBIOS) and **replace this values** in your **config.plist**;
- **Remove this section** from your **config.plist** since you **don't have iGPU** anymore:
```diff
-	<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
-	<dict>
-		<key>AAPL,ig-platform-id</key>
-		<data>AwCSPg==</data>
-	</dict>
```
- Edit **USBPorts.kext** _(on Mac you need to right click and Show Package Contents, edit info.plist inside de Contents folder)_ and change in **two places** the new SMBIOS:
```diff
	<key>IOKitPersonalities</key>
	<dict>
-	<key>iMac19,2-XHC</key>
+	<key>MacPro7,1-XHC</key>
```
and
```diff
	<key>model</key>
-	<string>iMac19,2</string>
+	<string>MacPro7,1</string>
```
- **Copy** the files **CPUFriend.kext** and **CPUFriendDataProvider.kext** from folder **other/mapro71** in this repo to your **Kexts** folder
- **Enable** the **CPUFriend.kext**, **CPUFriendDataProvider.kext** and **RestrictEvents.kext** in your **config.plist** _(this kexts are supplied but disabled by default):
```diff
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
-		<false/>
+		<true/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string>Contents/MacOS/CPUFriend</string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>CPUFriend.kext</string>
	</dict>
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
-		<false/>
+		<true/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string></string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>CPUFriendDataProvider.kext</string>
	</dict>
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
-		<false/>
+		<true/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string>Contents/MacOS/RestrictEvents</string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>RestrictEvents.kext</string>
	</dict>
```
- Remind to **Reset NVRAM** if you are changing from iMac19,2 running to new MacPro7,1 **prior to reboot MacOS** _(if you need to generate your own CPUFriendDataProvider.kext see the apendix below for instructions)_.

## Apendix

### USB Ports

The included **USBPorts.kext** with USB mapping is for the **Gigabyte z370N WiFi 1.0 and iMac19,2 SMBIOS only** with some **USB 3** ports, one **USB type C** and one **internal Bluetooth USB** port enabled.

- If you want to map your USB ports yourself, **please read** [this guide](https://www.tonymacx86.com/threads/the-new-beginners-guide-to-usb-port-configuration.286553/) for USB mapping using [Hackintool](https://github.com/headkaze/Hackintool);
- Note that **you need Big Sur 11.2.3** to this guide work. **Later versions do not work** for port remapping;
- The required **USBInjectAll.kext** is supplied but it's disabled in **config.plist**. You can **enable it** and **disable USBPorts.kext** to map the ports:
```diff
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
-		<false/>
+		<true/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string>Contents/MacOS/USBInjectAll</string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>USBInjectAll.kext</string>
	</dict>
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
-		<true/>
+		<false/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string></string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>USBPorts.kext</string>
	</dict>
```
- Enable **USB Ports Limit** quirk:
```diff
	<key>XhciPortLimit</key>
-	<false/>
+	<true/>
```
- **Follow the guide** and determine what ports you want to use _(must be 15 or less ports)_;
- Generate new **USBPorts.kext** using **Hackintool**, copy it to **Kexts folder** and **enable it** _(remind to disable USBInjectAll.kext and set XhciPortLimit to false again)_:
```diff
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
+		<false/>
-		<true/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string>Contents/MacOS/USBInjectAll</string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>USBInjectAll.kext</string>
	</dict>
	<dict>
		<key>Comment</key>
		<string></string>
		<key>MaxKernel</key>
		<string></string>
		<key>PlistPath</key>
		<string>Contents/Info.plist</string>
		<key>Enabled</key>
+		<true/>
-		<false/>
		<key>MinKernel</key>
		<string></string>
		<key>ExecutablePath</key>
		<string></string>
		<key>Arch</key>
		<string>Any</string>
		<key>BundlePath</key>
		<string>USBPorts.kext</string>
	</dict>
```

### CPUFriendDataProvider

The **iMacPro1,1 and MacPro7,1** SMBIOS redirect all graphics processing to dedicated graphics card (your AMD GPU). This can increase graphics processing and bypass DRM issues. But in real life, **iMacPro and MacPro uses Intel Xeon** CPUs and **power management will not work for your Intel Cofee Lake** or other CPUs. 

This can be resolved using **CPUFriend.kext** and a **CPUFriendDataProvider.kext** _(frequency vectors)_ that are provided in repo for Cofee Lake CPUs. But if you need to generate this file yourself, you can use the [CPUFriendFriend](https://github.com/corpnewt/CPUFriendFriend) as described in [this guide](https://dortania.github.io/OpenCore-Post-Install/universal/pm.html#enabling-x86platformplugin).

Another way is use the **Tools** that come with **CPUFriend.kext** to **generate CPUFriendDataProvider.kext** using the steps below on your MacOS:
 
- Download the [CPUFriend](https://github.com/acidanthera/CPUFriend) repo:
```bash
git clone git@github.com:acidanthera/CPUFriend.git
```
- Go inside the **Tools** folder;
- **Copy the relevant power management file from MacOS system**. In our case, we need **Cofee Lake** _(for i7 8700)_ so the best Mac model that fits this bill is **iMac19,2** _(you can search the model that match your processor if you use another generation)_. The file we need to copy is the **board-id** of Mac19,2 named **Mac-63001698E7A34814.plist** _(you must replace with board id of model you need)_:
```bash
sudo cp /System/Library/Extensions/IOPlatformPluginFamily.kext/Contents/PlugIns/X86PlatformPlugin.kext/Contents/Resources/Mac-63001698E7A34814.plist .
```
- Run the **ResourceConverter.sh** Tool using the **board-id file** that you copied to current folder:
```bash
sudo chmod +x ResourceConverter.sh
./ResourceConverter.sh -k Mac-63001698E7A34814.plist
```
- The file **CPUFriendDataProvider.kext** will be generated. Just **copy this file to your Kext folder in your EFI volume**, the same folder of **CPUFriend.kext** file _(remind to enable this kexts in config.plist)_

### Brazilian ABNT2 keyboard
On Brazil, to make your **ABNT 2 keyboard** default, change language and keyboard layout in your **config.plist** inside **NVRAM** key section:
```xml
<key>prev-lang:kbd</key>
<string>pt-BR:128</string>
```
