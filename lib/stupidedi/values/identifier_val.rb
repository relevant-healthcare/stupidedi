module Stupidedi
  module Values

    class IdentifierVal < SimpleElementVal

      class Empty < IdentifierVal
        def empty?
          true
        end

        def present?
          false
        end

        def inspect
          def_id = element_def.try{|d| "[#{d.id}]" }
          "IdentifierVal.empty#{def_id}"
        end

        def ==(other)
          other.is_a?(self.class)
        end
      end

      class NonEmpty < IdentifierVal
        attr_reader :delegate

        def initialize(delegate, element_def)
          @delegate = delegate
          super(element_def)
        end

        def inspect
          def_id = element_def.try{|d| "[#{d.id}]" }
          "IdentifierVal.value#{def_id}(#{@delegate})"
        end

        def empty?
          false
        end

        def present?
          true
        end

        # Beware, not commutative
        #   String.value('XX') == 'XX'
        #                 'XX' != String.value('XX')
        def ==(other)
          if other.is_a?(self.class)
            delegate == other.delegate
          else
            delegate == other
          end
        end
      end

    end

    # Constructors
    class << IdentifierVal
      def empty(element_def = nil)
        IdentifierVal::Empty.new(element_def)
      end

      # Convert data read from ElementReader
      def value(string, element_def)
        IdentifierVal::NonEmpty.new(string, element_def)
      end

      # Convert a ruby String value
      def from_string(string, element_def = nil)
        value(string, element_def)
      end
    end

    # Prevent direct instantiation of abstract class IdentifierVal
    IdentifierVal.eigenclass.send(:protected, :new)
    IdentifierVal::Empty.eigenclass.send(:public, :new)
    IdentifierVal::NonEmpty.eigenclass.send(:public, :new)

  end
end