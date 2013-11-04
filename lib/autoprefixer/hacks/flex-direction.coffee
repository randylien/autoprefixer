flexSpec    = require('./flex-spec')
Declaration = require('../declaration')

class FlexDirection extends Declaration
  @names = ['flex-direction', 'box-direction', 'box-orient']

  # Return property name by final spec
  normalize: (prop) ->
    'flex-direction'

  # Use two properties for 2009 spec
  insert: (decl, prefix) ->
    [spec, prefix] = flexSpec(prefix)
    if spec == 2009
      value  = decl.value
      orient = if value.indexOf('row') != -1 then 'horizontal' else 'vertical'
      dir    = if value.indexOf('reverse') != -1 then 'reverse' else 'normal'

      cloned = @clone(decl)
      cloned.prop  = prefix + 'box-orient'
      cloned.value = orient
      decl.parent.insertBefore(decl, cloned)

      cloned = @clone(decl)
      cloned.prop  = prefix + 'box-direction'
      cloned.value = dir
      decl.parent.insertBefore(decl, cloned)
    else
      super

  # Clean two properties for 2009 spec
  old: (prop, prefix) ->
    [spec, prefix] = flexSpec(prefix)
    if spec == 2009
      [prefix + 'box-orient', prefix + 'box-direction']
    else
      super

module.exports = FlexDirection
