rails-misc
==========

# Copy lib/* to Rails.root/lib

```
cp lib/* Rails.root/lib
```

# Edit Rails.root/config/application.rb

```
config.autoload_paths += %W(#{config.root}/lib)
```

# Edit Rails.root/initializer/application.rb

```
require "error_message_on"
require "validations"
```
