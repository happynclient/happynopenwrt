## happyn openwrt client


## build (ubuntu20.04)

1. install dep packages 
```
sudo apt-get install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc zip
```

2. config openwrt sdk

```
wget https://downloads.openwrt.org/releases/21.02.0/targets/x86/64/openwrt-sdk-21.02.0-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz
tar xvf openwrt-sdk-21.02.0-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz

cd openwrt-sdk-21.02.0-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz
./scripts/feeds update -a
./scripts/feeds install -a 
```

3. config happynopenwrt
```
make defconfig

git clone https://github.com/happynclient/happynopenwrt.git package/happyn

make package/happyn/n2n-happyn/compile V=s
make package/happyn/luci-app-happynet/compile V=s

#ipk file to sdk/bin/packages/xx
```
