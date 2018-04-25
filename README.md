# formation

`$ crystal init app` replacement

## Usage
Recommended usage
```
$ shards build                        # build formation
$ mv bin/formation ~/bin/formation    # move the binary to somewhere in your path
$ cd the/place/you/keep/projects      # change your directory to where you keep projects
$ formation MyAppName                 # form a project in the current directory named my-app-name
```

If the [shards subcommand fallback PR](https://github.com/crystal-lang/shards/pull/202) gets accepted, this would be recommended usage
```
$ shards build                        # build formation
$ mv bin/formation ~/bin/shards-form  # move the binary to somewhere in your path
$ cd the/place/you/keep/projects      # change your directory to where you keep projects
$ shards form MyAppName               # form a project in the current directory named my-app-name
```

## Contributing

1. Fork it ( https://github.com/willamin/formation/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [willamin](https://github.com/willamin) Will Lewis - creator, maintainer
