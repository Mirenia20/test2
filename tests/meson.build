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
