The Amazing Wireframe shader
By Davit Naskidashvili

VacuumShaders 2014
www.facebook.com/VacuumShaders

************************************



- Wireframe shader requires mesh with predifined data stored inside color and vertex buffers.


- There are two ways to generate wireframe ready mesh:
1. Generate asset in editor. Select mesh and go to Assets/Vacuum/Wireframe/Generate and replace. Asset file will be created and saved inside "Assets/Wireframed Meshes" folder.
2. Rebuild mesh at runtime. Assign Wireframe script to the object Menu/Component/Vacuum/Wireframe.


- Wireframe script generates only one instance of the mesh and saves it's ID to avoid same calulations in case of several request of that mesh.
- Avoid using wireframed mesh on objects with multiple submaterials.

Support thread:
http://forum.unity3d.com/threads/wireframe-the-amazing-wireframe-shader.251143/

 
********************************************************************
This package does not contains tools to generate wireframed meshes.
********************************************************************