Puppet::Functions.create_function(:hasharray_merge) do
  dispatch :hasharray_merge do
    param 'Hash', :hash1
    param 'Hash', :hash2
  end

  def hasharray_merge(hash1,hash2)
    hash = {}
    hash1.each do |k,v|
      hash[k] = v + hash2[k]
    end
    return hash
  end
end
