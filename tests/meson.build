test_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1'),
  dependency('gio-2.0'),
  dependency('gee-0.8'),
  dependency('polkit-gobject-1'),
]

ui_build_dir = meson.build_root() / 'data'

exe = executable('analysis_page_test',
  ['test_analysis_page.vala', '../src/analysis_page.vala'],
  dependencies: test_deps,
  vala_args: ['--gresources', '../data/raccoon.gresource.xml', '--gresourcesdir', ui_build_dir],
)

test('analysis_page', exe)
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
