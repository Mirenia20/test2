desktop_file = i18n.merge_file(
        input: 'Raccoon.jh.xz.desktop.in',
       output: 'Raccoon.jh.xz.desktop',
         type: 'desktop',
       po_dir: '../po',
      install: true,
  install_dir: get_option('datadir') / 'applications'
)

desktop_utils = find_program('desktop-file-validate', required: false)
if desktop_utils.found()
  test('Validate desktop file', desktop_utils, args: [desktop_file])
endif

appstream_file = i18n.merge_file(
        input: 'Raccoon.jh.xz.metainfo.xml.in',
       output: 'Raccoon.jh.xz.metainfo.xml',
       po_dir: '../po',
      install: true,
  install_dir: get_option('datadir') / 'metainfo'
)

appstreamcli = find_program('appstreamcli', required: false, disabler: true)
test('Validate appstream file', appstreamcli,
     args: ['validate', '--no-net', '--explain', appstream_file])

install_data('Raccoon.jh.xz.gschema.xml',
  install_dir: get_option('datadir') / 'glib-2.0' / 'schemas'
)



# Generate UI files from blueprint files.
blueprints = custom_target('blueprints',
  input: files(
	'ui/gtk/help-overlay.blp',
	'ui/window.blp',
	'ui/history_dialog.blp',
	'ui/preferences_dialog.blp',
	'ui/history_row.blp',
	'ui/path_row.blp',
	'ui/analysis_page.blp',
	'ui/main_page.blp',
	'ui/w_burger_menu.blp',
  ),
  output: '.',
  command: [find_program('blueprint-compiler'), 'batch-compile', '@OUTPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@'],
)


gschema_file = 'Raccoon.jh.xz.gschema.xml'


install_data('Raccoon.jh.xz.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0/schemas')
)




compile_schemas = find_program('glib-compile-schemas', required: false, disabler: true)

if compile_schemas.found()
  message('glib-compile-schemas found at: ' + compile_schemas.path())
  
  test('Validate schema file',
    compile_schemas,
    args: ['--strict', '--dry-run', meson.current_source_dir()]
  )
meson.add_install_script(
  compile_schemas,
  join_paths(get_option('prefix'), get_option('datadir'), 'glib-2.0/schemas')
)

else
  message('glib-compile-schemas NOT found - schema will not be compiled on install')
endif


service_conf = configuration_data()
service_conf.set('bindir', get_option('prefix') / get_option('bindir'))
configure_file(
  input: 'Raccoon.jh.xz.service.in',
  output: 'Raccoon.jh.xz.service',
  configuration: service_conf,
  install: true,
  install_dir: get_option('datadir') / 'dbus-1' / 'services'
)

gen_css = custom_target('gen_css',
  input: files(
    'css/main.css',
  ),
  capture: true,
  output: 'style.css',
  command: [find_program('cat'), '@INPUT@'],
)



resource_files = files('raccoon.gresource.xml',)

resource_files = files('raccoon.gresource.xml')

raccoon_resources_ui = gnome.compile_resources(
  'resources',
  resource_files,
  source_dir: meson.current_source_dir(),  
  c_name: 'raccoon',
  dependencies: [blueprints, gen_css],
  export: true #res avail for other dirs
)

subdir('icons')

