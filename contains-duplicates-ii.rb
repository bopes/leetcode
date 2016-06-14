def contains_nearby_duplicate(nums, k)

    n = nums.length

    indexes = Hash.new([])

    nums.each_with_index do |num, idx|
        if !(indexes[num].empty?) && idx - indexes[num][-1] <= k
            return true
        end
        indexes[num] += [idx]
    end

    false

end