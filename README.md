# My Neovim configs

![Neovim image](https://github.com/user-attachments/assets/56c51452-14da-409c-aaf4-c9d67846d182)

```dart
// here should be nvim binary installation 
export PATH="$PATH":"/opt/nvim/bin"
// and you need to have these libraries installed already
// to avoid issues with the clipboard and more
sudo apt install xclip git make cmake gcc g++ yarn clang pkg-config ninja-build fzf ripgrep fd-find luarocks
```

For running Desktop enviroment

```dart
// set path for clang
which clang++
// and, with the path printed
export CXX=/path/to/clang++
```

For running Desktop that requires GTK3
```dart
// if you have issues with gtk3,
// just run
sudo apt install libgtk-3-dev
```

## Language requirements

## Using mason

...

## Manual installation

* Lua:
    ```dart
       // install ninja
       python3 -m pip install ninja
       // go to development folder and run
       git clone https://github.com/LuaLS/lua-language-server
       cd lua-language-server
       // and run this 
       ./make.sh
       // create a symbolic link to usr 
       sudo ln -s ~/development/lua-language-server/bin/lua-language-server /usr/local/bin/lua-language-server
       // then just export the binary file
       export PATH="$PATH":"$HOME/development/lua-language-server/bin/lua-language-server"
    ```
* Docker:
    ```dart
        npm install -g dockerfile-language-server-nodejs
    ```
* Json, HTML, CSS:
    ```dart
        // run this
        npm i -g vscode-langservers-extracted
    ```
* Java:
    You need to that we use `jdtls` [docs](https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file)

    1. `eclipse.jdt.ls` requires `Java 21`
    2. The `jdtls` script requires `Python 3.9`
    3. Install this using mason.nvim calling `MasonInstall jdtls java-test java-adapter-server`

    To avoid missing some configurations, [see the correct setup](https://lsp-zero.netlify.app/blog/setup-with-nvim-jdtls.html) 
    ```dart
      // Where should be installed Java:
      '/usr/lib/jvm/jdk-21'
      // You should have these variables in your .bashrc or .zshrc
      export JAVA_HOME="/usr/lib/jvm/jdk-21"
      export PATH="$PATH":"$JAVA_HOME/bin"
    ```

* Node and typescript
    ```dart
        // First at all install Nodejs and Npm
        // Visit, and follow the steps to install them
        // https://nodejs.org/en/download

        // then install typescript globaly
        sudo npm i -g typescript typescript-language-server
        sudo npm i -g tailwindcss-language-server
        sudo npm install -g prettier eslint

        // At this point, just at these vars into your .bashrc or .zshrc
        export PATH="$PATH":"$HOME/.nvm/versions/node/v22.14.0/bin/typescript-language-server"
        export PATH="$PATH":"/usr/bin/npm"
    ```
* Golang
    ```dart
        // Visit: https://go.dev/doc/install
        //
        // To enable LSP commands
        // execute:
        sudo apt install gopls
        // so, after install gopls, go to your $HOME path
        // and execute this (get all the important stuff
        // of go that you need)
        go install golang.org/x/tools/gopls@latest
        // and the docs
        go get -u github.com/zmb3/gogetdoc
        //
        // You probably, after the go installation 
        // will need to have these vars in your .bashrc or .zshrc
        export PATH="$PATH":"$HOME/go/bin"
        export PATH="$PATH":"/usr/local/go/bin"
    ```
* Clangd
    ```dart
        // see: https://clangd.llvm.org/installation
        //
        // for linux, we use
        //
        sudo apt-get install clangd-15
        //
        // This will install clangd as /usr/bin/clangd-15. Make it the default clangd:
        //
        sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-15 100
        sudo apt-get install clang-format cpplint

        // Put the path of the clangd into your .bashrc or .zshrc
        export PATH="$PATH":"/usr/bin/clangd-15"

    ```
* Python3
    ```dart
        // python3 or python3.12 or major
        // choose the version that you want
        //
        // at this point, i prefer python3
        npm i -g python3 //-g
        npm config set python3 /usr/bin/python3

        /// optional command
        python3 -m ensurepip --upgrade
        python3 -m pip install --user --upgrade pynvim

        /// you should have installed python3
        /// and you need to have this var in your .bashrc or .zshrc
        export PATH="$PATH":"/usr/bin/python<version>"
    ```
* Flutter
    If you're facing issues with linux not recognizing your phone
    check these sites:

    1. https://askubuntu.com/questions/863587/adb-device-list-doesnt-show-phone
    2. https://stackoverflow.com/questions/77925533/android-adb-no-permissions-for-device
    ```dart
        // Where should be installed flutter:
        '~/development/flutter/bin/flutter'
        // You should have these variables in your .bashrc or .zshrc
        export PATH="$PATH":"$HOME/development/flutter/bin/"
        export PATH="$PATH":"$HOME/development/flutter/bin/cache/dart-sdk/bin/"
        export PATH="$PATH":"$HOME/.pub-cache/bin"
        // After Android studio installation
        // you should have these variables configured too
        export ANDROID_HOME="$HOME/Android/Sdk" 
        export PATH="$PATH":"$HOME/development/flutter/bin/"
        export PATH="$PATH":"$HOME/development/flutter/bin/cache/dart-sdk/bin/"
        export PATH="$PATH":"$HOME/Android/Sdk/platform-tools"
        export PATH="$PATH":"$HOME/Android/Sdk/tools"
        export PATH="$PATH":"$HOME/Android/ndk-build"
        export PATH="$PATH":"$HOME/Android/Sdk/"
        path+=${ZDOTDIR:-~}/.zsh_functions
    ```
* Rust (standard installation)
    ```dart
      // ensure that you have fontconfig-devel
      // installed on your linux distro
      // or install libfontconfig1-dev
      //
      rustup component add rustfmt clippy
      // then, add the rust-analyzer with rustup
      rustup component add rust-analyzer
    ```

## Most new version

* Support for native winbar
* Support for native diagnostics (just parsing them to `vim.diagnostic`)
* Support for diagnostics preview in Neotree
* Improved diagnostics API and UI
