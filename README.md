# RichRC

RichRC (Rich Rails Console) loads [hirb](https://github.com/cldwalker/hirb) and [wirble](http://pablotron.org/software/wirble/) in rails 3 console without editing files in rails app directory. 

Hirb and wirble are excellent IRB-extension which makes data more readable. In rails 2, we can simply require gems in IRB and start using them. However, In Rails 3, it's needed to add gems into `Gemfile` before using it. Sometimes it doesn't make sense to add IRB-extension gems into rails app Gemfile (Maybe not all developers want hirb and wirble, and it's annoying to add the gems whenever cloning a project). 

Inspired from [xdite's article](http://blog.xdite.net/?p=1839), the extra gems cloud be loaded before `Bundler.setup` is invoked. RichRC mimics the bootstrap process of rails console, load and initialize extra gems, and start console normally. 

## Installation

    $ gem install richrc hirb wirble

P.S. In RichRC's gemspec, it doesn't depend on hirb and wirble. If some of the gems are missing, RichRC simply ignore them.

## Running RichRC

    $ cd railsapp
    $ richrc # instead of `rails console`

That's all :)

The original rails console is not affected. If problems occured with RichRC, you can simply fallback to `rails console`.

## Possible Issues

* Theoretically, if hirb and wirble(and their dependent gems) conflict with gems in `Gemfile`, it may cause problems. However, I never encounter this situation. Hacking Bundler.setup might be a better way. 

Fell free to report issues in Github's issue tracker. 

## License

See MIT-License for details. 

