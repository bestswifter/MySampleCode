这是一篇水文，讲讲踩坑的经历。

# 背景

起因是在写 Node 时，受够了 `require ('../../../../helper.js')` 这种相对路径。不够直观不谈，如果将来在别的地方用，都不能直接 copy 过来，还得重新计算相对路径，因此希望用绝对路径（换句话说就是永远相对根路径）来表示。

一种比较简单的方案是封装 `require` 函数：

```js
global.rootRequire = function(name) {
    return require(__dirname + '/' + name);
}
```

在我们的 `rootRequire` 函数中，所有的路径都会被加上 `__dirname` 的前缀，也就实现了绝对路径。

这么做功能上没有问题，然而似乎 VSCode 对这种写法支持得不够好（有了解的大佬还望指教），表现为以下两个问题：

1. 虽然我们把 `rootRequire` 定义为全局的，但在别的文件中输入这个单词时，并没有自动补全
2. 通过这种方式引入的模块，不能跳转到模块的实现，也看不到模块的内部结构，如果用 `require` 引入则没有问题。

经过更进一步的测试，甚至于这种写法也是不行的：

```js
let r = require
let a = r('../test/a')
```

在 VSCode 中会发现 `a` 的类型为 `any` 并且丢失了很多信息。

# 解决方案

换句话说，封装 `require` 的路是行不通了，只能用原生的 `require` 函数，那么只能看看有什么办法可以影响到模块查找的流程了。

内置的那套流程和顺序肯定是改不了，看起来只能从 `NODE_PATH` 这个全局变量下手了。我们知道 `require` 函数会去 `NODE_PATH` 的目录里查找模块，所以只要把它设置为工程的根路径，就可以实现绝对路径加载了。试验一下，项目目录如下所示：

```
project
    |-----main
           |------index.js
    |-----util
           |------utils.js
```

很简单的定义一下 `utils.js`，就导出一个对象：

```js
// utils.js
module.exports = {
    key:' value'
}
```

在 `index.js` 中这么写：

```js
let utils = require('utils/utils')
console.log(utils.key)
```

然后执行 `node main/index.js`，肯定会编译失败。

但如果指定了 `NODE_PATH` 就不一样了，此时可以正常运行：

```shell
export NODE_PATH=$PWD && node main/index.js
```

# 优化

直接在命令行中指定 `NODE_PATH` 有两个问题：

1. 改变了项目的启动方式，别的开发者也会受到影响，不过这一点问题不大，因为一般都是通过命令来启动的。
2. 如果在不同的路径下启动 node，那么 `$PWD` 是会变的，这种方式不够安全。

所以比较好的做法是，在入口文件中指定 `NODE_PATH`，因为这个文件的路径一般不会改变。所以 `index.js` 可以改造成这样：

```js
let path = require('path')
process.env.NODE_PATH = path.resolve(__dirname, '../') ;
require('module').Module._initPaths();

let utils = require('utils/utils')

console.log(utils.key)
```

这种写法的好处在于，无论我们在哪里执行 `node path/to/index.js` 都会得到正确的结果。

最后还需要修正一下写 `require` 函数时，路径补全的问题，只要在根目录里面加上一个 `jsconfig.json` 文件并添加如下内容即可：

```json
{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "baseUrl": "./",
  },
  "exclude": [
    "node_modules"
  ]
}
```

核心在于 `"baseUrl": "./"` 这一行。这样当我们写 `utils` 这个单词的时候，就可以享受到自动补全了。

至此，无论是 Node 的执行，还是路径补全，抑或是定义跳转功能，都正常工作了。