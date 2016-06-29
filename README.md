No Class Element Selectors
===
A linter for scss-lint (https://github.com/brigade/scss-lint). Warns if a selector combines a class and element, example ".foo p". Rather assign a unique class name to p.



Config
---

linters:

    NoClassElementSelectors:
        # set to true to enable
        enabled: true
        # elements to ignore. Optional - if ommitted or empty, rule with trigger on all .class element selectors
        ignoredElements : [i, li]

Use
---
This linter is currently not available as a Gem. To use it, place /lib/NoClassElementSelectors.rb in a folder on your system, then add that folder to your .scss-lint.yml file as follows

    plugin_directories: ['/foo/bar']