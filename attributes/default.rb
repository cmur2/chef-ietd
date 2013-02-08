
# HINT: RFC 3720 requires <pass> to be 12 characters long. This is enforced e.g. by MS Initiator.
#default[:ietd][:incominguser] = ['user', 'pass']

# HINT: RFC 3720 requires <pass> to be 12 characters long. This is enforced e.g. by MS Initiator.
#default[:ietd][:outgoinguser] = ['user', 'pass']

default[:ietd][:targets] = []

default[:ietd][:initiators_allow] = [
  {
    "target_iqn" => "ALL",
    "sources" => ["ALL"] # source regexs without ^ and $ or IP addresses (CIDR allow)
  }
]

default[:ietd][:targets_allow] = [
  {
    "target_iqn" => "ALL",
    "sources" => ["ALL"] # source IP addresses (CIDR allow)
  }
]
