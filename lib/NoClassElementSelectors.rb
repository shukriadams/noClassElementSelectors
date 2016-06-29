module SCSSLint
    class Linter::NoClassElementSelectors < Linter
        include LinterRegistry

        def visit_root(_node)
            @ignoredElements = []

            if (config['ignoredElements'] != nil)
                 @ignoredElements = config['ignoredElements']
            end

            yield # Continue linting children
        end

        def visit_rule(node)
            selectors = node.parsed_rules.to_s.split(" ")
            hasClass = false
            hasElement = false
            selectors.each do |selector|
                if selector.start_with?('.')
                    hasClass  = true
                end

                if !selector.start_with?('.') and !@ignoredElements.include?(selector)
                    hasElement = true
                end

                if hasClass and hasElement
                    add_lint(node, "Avoid selectors that combine classes and elements - give your elements unique class names instead.")
                    break
                end

            end

        end

    end
end