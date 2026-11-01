# dcat.yazi

[Yazi](https://github.com/sxyazi/yazi) 3d model previews with [dcat](https://github.com/Murat65536/dcat).

## Requirements

- Yazi 26.5.6+
- [dcat](https://github.com/Murat65536/dcat#install) 1.7.0+

## Install

```sh
ya pkg add Murat65536/dcat
```

Then add to `~/.config/yazi/yazi.toml`:

```toml
[plugin]
prepend_preloaders = [
  { url = "*.{3d,3ds,3mf,ac3d,acc,amf,ase,ask,assbin,b3d,blend,bsp,cob,dae,dxf,enff,fbx,glb,gltf,hmp,ifc,ifczip,iqm,irr,irrmesh,lwo,lws,lxo,md2,md3,md5mesh,mdc,mesh,mesh.xml,ms3d,ndo,nff,obj,off,ogex,ply,pmx,q3o,q3s,sib,smd,step,stl,stp,ter,vrm,x3d,x3db,xgl,zae,zgl}", run = "dcat" },
]
prepend_previewers = [
  { url = "*.{3d,3ds,3mf,ac3d,acc,amf,ase,ask,assbin,b3d,blend,bsp,cob,dae,dxf,enff,fbx,glb,gltf,hmp,ifc,ifczip,iqm,irr,irrmesh,lwo,lws,lxo,md2,md3,md5mesh,mdc,mesh,mesh.xml,ms3d,ndo,nff,obj,off,ogex,ply,pmx,q3o,q3s,sib,smd,step,stl,stp,ter,vrm,x3d,x3db,xgl,zae,zgl}", run = "dcat" },
]
```

## Opening models

To open models in the interactive viewer with Enter:

```toml
[opener]
dcat = [
  { run = 'dcat %s1 || { echo "Press enter to exit"; read _; }', block = true, desc = "View in dcat", for = "unix" },
  { run = 'dcat %s1 || pause', block = true, desc = "View in dcat", for = "windows" },
]

[open]
prepend_rules = [
  { url = "*.{3d,3ds,3mf,ac3d,acc,amf,ase,ask,assbin,b3d,blend,bsp,cob,dae,dxf,enff,fbx,glb,gltf,hmp,ifc,ifczip,iqm,irr,irrmesh,lwo,lws,lxo,md2,md3,md5mesh,mdc,mesh,mesh.xml,ms3d,ndo,nff,obj,off,ogex,ply,pmx,q3o,q3s,sib,smd,step,stl,stp,ter,vrm,x3d,x3db,xgl,zae,zgl}", use = [ "dcat", "edit", "reveal" ] },
]
```

Add any dcat flags to `run`, like `dcat --spin 1 %s1`. Run `dcat --controls` for the keys.
