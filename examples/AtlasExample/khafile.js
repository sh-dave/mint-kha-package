var project = new Project('AtlasExample');

project.localLibraryPath = '../../..';

project.addLibrary('mint-kha-package');
project.addLibrary('mint');

project.addAssets('../../assets/**');
project.addSources('src');

project.windowOptions.width = 512;
project.windowOptions.height = 512;

return project;
