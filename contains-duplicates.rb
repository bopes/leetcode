def contains_duplicate(nums)

    counts = Hash.new(0)

    nums.each do |num|
        counts[num] += 1
        if counts[num] == 2
            return true
        end
    end

    false

end