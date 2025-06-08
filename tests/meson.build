test_deps = [
  raccoon_dep,  # оголошено у корені
  dependency('gio-2.0'),
  dependency('glib-2.0')
]

utils_test = executable('test_utils',
  ['test_utils.vala'],
  dependencies: test_deps,
  vala_args: ['--enable-experimental']
)

test('utils', utils_test)

