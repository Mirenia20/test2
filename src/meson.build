racoon_sources = [
	'main.vala',
	'application.vala',
	'window.vala',
	'history_dialog.vala',
	'preferences_dialog.vala',
	'history_row.vala',
	'path_row.vala',
	'analysis_page.vala',
	'main_page.vala',
    'utils.vala',
    'directory_history.vala'
    ]

raccoon_deps = [
  dependency('gtk4'),
  dependency('polkit-gobject-1'),
  dependency('gee-0.8'),
  dependency('libadwaita-1', version: '>=1.4'),
  dependency('gio-2.0'),
  dependency('glib-2.0')
]

'''
lib_raccoon = static_library('raccoon',
  racoon_sources,
  dependencies: racoon_deps,
  vala_args: ['--enable-experimental'],
  include_directories: include_directories('.'),
  vala_header: 'raccoon.h',
  vala_vapi: 'raccoon.vapi'  # <<< ВАЖЛИВО
)

raccoon_dep = declare_dependency(
  include_directories: include_directories('.'),
  link_with: lib_raccoon,
  sources: ['raccoon.vapi', 'raccoon.h']
)

meson.override_dependency('raccoon', raccoon_dep)
'''


executable('racoon', racoon_sources,raccoon_resources_ui,
  dependencies: raccoon_deps,
  vala_args: [
    '--gresources', resource_files,
    #'--gresourcesdir=data/',
    '--enable-experimental', '--pkg', 'posix',
  ],
  include_directories: config_inc,
  install: true,
)



