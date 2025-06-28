# My Neovim configs

![Neovim image](https://github.com/user-attachments/assets/56c51452-14da-409c-aaf4-c9d67846d182)

```lua
-- here should be nvim binary installation 
export PATH="$PATH":"/opt/nvim/bin"
```

## Language requirements

* Java:
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
        npm i typescript -g

        // At this point, just at these vars into your .bashrc or .zshrc
        export PATH="$PATH":"$HOME/.nvm/versions/node/v22.14.0/bin/typescript-language-server"
        export PATH="$PATH":"/usr/bin/npm"
    ```
* Golang
    ```dart
        // Visit: https://go.dev/doc/install
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
        // sudo apt-get install clangd-15
        //
        // This will install clangd as /usr/bin/clangd-15. Make it the default clangd:
        //
        // sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-15 100

        // Put the path of the clangd into your .bashrc or .zshrc
        export PATH="$PATH":"/usr/bin/clangd-15"

    ```
* Python3
    ```dart
        /// I'll assume that you have Nodejs and Npm
        npm install --python=python3
        // or
        npm i python3 //-g
        npm config set python3 /usr/bin/python3

        /// Run
        python3 -m ensurepip --upgrade
        python3 -m pip install --user --upgrade pynvim

        /// you should have installed python3
        /// and you need to have this var in your .bashrc or .zshrc
        export PATH="$PATH":"/usr/bin/python3"
    ```
* Flutter
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

## Most new version

* Support for native winbar
* Support for native diagnostics (just parsing them to `vim.diagnostic`)
* Support for diagnostics preview in Neotree
* Improved diagnostics API and UI
