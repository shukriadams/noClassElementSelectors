module SCSSLint
    class Linter::NoClassElementSelectors < Linter
        include LinterRegistry

        def visit_root(_node)
            @ignoredElements = []

            if (config['ignoredElements'] != nil)
                 @ignoredElements = config['ignoredElements']
            end

            @depth = 1
            @root = ""

            yield # Continue linting children
        end


        def visit_rule(node)

            selectors = node.parsed_rules.to_s.split(" ")
            isViolatingElement = false

            selectors.each do |selector|

                if @depth == 1
                    @root = selector
                end

                if !selector.start_with?('.') and !selector.start_with?('&') and !@ignoredElements.include?(selector)
                    isViolatingElement = true
                end

            end

            if @depth > 1 and @root.start_with?('.') and isViolatingElement
                add_lint(node, "Avoid selectors that combine classes and elements - give your elements unique class names instead.")
            else
                @depth += 1
                yield # Continue linting children
                @depth -= 1
            end

            #yield # Continue linting children
        end

    end
end
