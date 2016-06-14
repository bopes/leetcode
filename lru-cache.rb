class LRUCache

    attr_accessor :head, :tail, :num_items, :max_items

    def initialize(max_items)
        @max_items = max_items
        @table = Hash.new
        @head = nil
        @tail = nil
        @num_items = 0
    end

    def get(key)

        if @table.has_key?(key)
            this_node = @table[key]
        else
            return -1
        end

        if this_node == @tail

        elsif this_node == @head
            @head = @head.next_node
            @head.prev_node = nil

            this_node.prev_node = @tail
            @tail.next_node = this_node
            @tail = this_node

        else
            this_node.prev_node.next_node = this_node.next_node
            this_node.next_node.prev_node = this_node.prev_node

            this_node.prev_node = @tail
            @tail.next_node = this_node
            @tail = this_node
        end

        return this_node.value

    end

    def set(key, value)

        if @table.has_key?(key)
            this_node = @table[key]
            this_node.value = value

            if this_node == @tail

            elsif this_node == @head
                @head = this_node.next_node
                @head.prev_node = nil

                @tail.next_node = this_node
                this_node.prev_node = @tail
                @tail = this_node

            elsif this_node != @tail
                this_node.prev_node.next_node = this_node.next_node
                this_node.next_node.prev_node = this_node.prev_node

                @tail.next_node = this_node
                this_node.prev_node = @tail
                @tail = this_node
            end

        elsif @head == nil && @max_items > 0
            @num_items += 1
            new_node = Node.new(key, value, nil, nil)
            @table[key] = new_node
            @head = new_node
            @tail = new_node

        elsif @max_items > 0
            @num_items += 1
            if @num_items > @max_items && @num_items > 1
                @table.delete(@head.key)
                @head.next_node ? @head = @head.next_node : @head = nil
                @head.prev_node = nil if @head
                @num_items -= 1
            end

            new_node = Node.new(key, value, @tail, nil)
            @table[key] = new_node

            @head = new_node if @head == nil

            @tail.next_node = new_node
            @tail = new_node
        end
    end

end

class Node
    attr_accessor :key, :value, :next_node, :prev_node

    def initialize(key, value, prev_node, next_node)
        @key = key
        @value = value
        @prev_node = prev_node
        @next_node = next_node
    end
end
