racoon_sources = [
	'main.vala',
	'application.vala',
	'window.vala',
	'history_dialog.vala',
	'preferences_dialog.vala',
	'history_row.vala',
        'path_row.vala',
        'settings_utils.vala',
        'analysis_page.vala',
	'main_page.vala',
    ]

racoon_deps = [
  config_dep,
  dependency('gtk4'),
  dependency('polkit-gobject-1'),
  dependency('gee-0.8'),
  dependency('libadwaita-1', version: '>= 1.4'),
 ]


executable('racoon', racoon_sources,raccoon_resources_ui,
  dependencies: racoon_deps,
  vala_args: [
    '--gresources', resource_files,
    #'--gresourcesdir=data/',
    '--enable-experimental', '--pkg', 'posix',
  ],
  include_directories: config_inc,
  install: true,
)



