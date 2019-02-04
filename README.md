# Coordinates and Teleport

## /tp posx posy poz rotx roty rotz rotw
Teleports you to the specified position or position and camera rotation
  + posx, posy, poz = Vector3, each no. respectively
  + rotx, roty, rotz, rotw = Vector4, each no. repectively
  
## /set_tpid id posx/rot posy poz rotx roty rotz rotw
Set's up id with position or position and camera rotation.
  + id = id you set for that position. id's can be any character (from what I know) as long as you don't have a space. They also don't carry throughout maps so you can have multiple ids that have the same name on different maps.
  + rot = if you do rot as the second variable it will also record you're current camera rotation
  
 ## /destroy_tpid id
 Destroys id in the database.
  
## /tpid id
Teleports you to the id.
If the id does not contain camera rotation data it doesn't move you're camera.

## Transfering ID's
In `C:\Users\User\AppData\Roaming\Fatshark\Vermintide 2\user_settings.config` you can find you id's.
Just use a search for your id until you find something like this (Note: the more unique the id, the easier it is to find it)
```lua
db = {
    inn_level = {
        weird = {
            pos = [
                -20.334
                3.38502
                7.16069
            ]
            rot = [
                0.517734
                0.149848
                -0.234181
                -0.809108
            ]
        }
    }
}
```
This example has weird as the id. You can copy this into another user_settings.config aslong as it is setup the same.
