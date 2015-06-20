resource_name = ENV['RESOURCE_NAME'] || 'Resource'
resource_type = ENV['RESOURCE_TYPE'] || throw('The environment variable $RESOURCE_TYPE must be specified')
resource_outputs = (ENV['RESOURCE_OUTPUTS'] || '').split(';')

resource resource_name, resource_type do
  ENV.each do |name, value|
    name = name.downcase

    value = if value.starts_with? 'json:'
      JSON.parse(value[/json:(.+)/, 1])
    else
      resolve(value)
    end

    if name.starts_with? 'cfn_'
      send(name[/cfn_(.+)/, 1], value)
    end
  end
end

output resource_name, Fn::ref(resource_name)

resource_outputs.each do |o|
  output o, Fn::get_att(resource_name, o)
end
