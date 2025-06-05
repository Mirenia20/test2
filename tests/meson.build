test_deps = [
    dependency('gio-2.0'),
    dependency('glib-2.0')
]

settings_utils_test = executable('test_settings_utils',
    ['test_settings_utils.vala', '../src/settings_utils.vala'],
    dependencies: test_deps,
    vala_args: ['--enable-experimental'],
    include_directories: config_inc
)

test('settings_utils', settings_utils_test,
    args: [meson.project_source_root() / 'data']
)
