@node kha/make flash --projectfile example-coloronly.khaproject --to build/example-coloronly
@node kha/make html5 --projectfile example-coloronly.khaproject --to build/example-coloronly
@node kha/make windows --projectfile example-coloronly.khaproject --to build/example-coloronly-dx9 --visualstudio vs2010 --graphics direct3d9
@node kha/make windows --projectfile example-coloronly.khaproject --to build/example-coloronly-dx11 --visualstudio vs2010 --graphics direct3d11
@node kha/make windows --projectfile example-coloronly.khaproject --to build/example-coloronly-gl --visualstudio vs2010 --graphics opengl

@pause
