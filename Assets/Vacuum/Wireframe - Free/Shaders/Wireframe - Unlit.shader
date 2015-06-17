// Compiled shader for all platforms, uncompressed size: 235.1KB

Shader "Vacuum/Wireframe/Unlit/Texture" {
Properties {
[MaterialToggle(V_WIRE_ANTIALIASING_ON)]  AO ("Antialiasing", Float) = 0
[MaterialToggle(V_WIRE_LIGHT_ON)]  LO ("Lights & Lightmaps effect wire", Float) = 0
[MaterialToggle(V_WIRE_FRESNEL_ON)]  FO ("Fresnel Wire", Float) = 0
 V_WIRE_COLOR ("Wire Color (RGBA)", Color) = (0,0,0,1)
 V_WIRE_SIZE ("Wire Size", Range(0,0.5)) = 0.05
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("MainTex", 2D) = "white" {}
}
SubShader { 
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 10 avg math (5..16)
 //        d3d9 : 13 avg math (7..20)
 // Stats for Fragment shader:
 //       d3d11 : 15 avg math (8..22), 1 avg texture (1..2)
 //        d3d9 : 19 avg math (9..29), 1 avg texture (1..2)
 Pass {
  Tags { "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  float value_4;
  vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_4 = 1.0;
  float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, retColor_1, vec4(value_4));
  retColor_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 srcColor_3;
  srcColor_3 = retColor_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, retColor_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  retColor_1 = srcColor_3;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  lowp vec4 srcColor_4;
  srcColor_4 = retColor_1;
  mediump float value_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_5 = 1.0;
  lowp float tmpvar_7;
  tmpvar_7 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_7 < V_WIRE_SIZE)) {
    value_5 = 0.0;
  };
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, retColor_1, vec4(value_5));
  srcColor_4 = tmpvar_8;
  retColor_1 = srcColor_4;
  gl_FragData[0] = srcColor_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 srcColor_3;
  srcColor_3 = retColor_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, retColor_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  retColor_1 = srcColor_3;
  _glesFragData[0] = srcColor_3;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  float value_4;
  vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  value_4 = 1.0;
  float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, retColor_1, vec4(value_4));
  retColor_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
// Stats: 16 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  mediump float tmpvar_3;
  tmpvar_3 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_3;
  lowp vec4 srcColor_4;
  srcColor_4 = retColor_1;
  mediump float value_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  value_5 = 1.0;
  lowp float tmpvar_7;
  tmpvar_7 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_7 < V_WIRE_SIZE)) {
    value_5 = 0.0;
  };
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, retColor_1, vec4(value_5));
  srcColor_4 = tmpvar_8;
  retColor_1 = srcColor_4;
  gl_FragData[0] = srcColor_4;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  mediump float tmpvar_4;
  tmpvar_4 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_4;
  lowp vec4 srcColor_5;
  srcColor_5 = retColor_1;
  mediump float value_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  value_6 = 1.0;
  lowp float tmpvar_8;
  tmpvar_8 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_8 < V_WIRE_SIZE)) {
    value_6 = 0.0;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, retColor_1, vec4(value_6));
  srcColor_5 = tmpvar_9;
  retColor_1 = srcColor_5;
  gl_FragData[0] = srcColor_5;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  mediump float tmpvar_3;
  tmpvar_3 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_3;
  lowp vec4 srcColor_4;
  srcColor_4 = retColor_1;
  mediump float value_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  value_5 = 1.0;
  lowp float tmpvar_7;
  tmpvar_7 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_7 < V_WIRE_SIZE)) {
    value_5 = 0.0;
  };
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, retColor_1, vec4(value_5));
  srcColor_4 = tmpvar_8;
  retColor_1 = srcColor_4;
  _glesFragData[0] = srcColor_4;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  vec3 tmpvar_4;
  vec3 t_5;
  t_5 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_4 = (t_5 * (t_5 * (3.0 - (2.0 * t_5))));
  vec4 tmpvar_6;
  tmpvar_6 = mix (mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), retColor_1, vec4(min (min (tmpvar_4.x, tmpvar_4.y), tmpvar_4.z)));
  retColor_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, retColor_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  retColor_1 = srcColor_3;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  lowp vec4 srcColor_4;
  mediump vec3 width_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_7;
  tmpvar_7 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 t_9;
  t_9 = max (min ((xlv_COLOR.xyz / ((width_5 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_8 = (t_9 * (t_9 * (3.0 - (2.0 * t_9))));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6, retColor_1, vec4(min (min (tmpvar_8.x, tmpvar_8.y), tmpvar_8.z)));
  srcColor_4 = tmpvar_10;
  retColor_1 = srcColor_4;
  gl_FragData[0] = srcColor_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, retColor_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  retColor_1 = srcColor_3;
  _glesFragData[0] = srcColor_3;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 tmpvar_4;
  tmpvar_4 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_4;
  vec3 tmpvar_5;
  vec3 t_6;
  t_6 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_5 = (t_6 * (t_6 * (3.0 - (2.0 * t_6))));
  vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_4, retColor_1, vec4(min (min (tmpvar_5.x, tmpvar_5.y), tmpvar_5.z)));
  retColor_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
// Stats: 16 math
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  mediump float tmpvar_3;
  tmpvar_3 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_3;
  lowp vec4 srcColor_4;
  mediump vec3 width_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 t_9;
  t_9 = max (min ((xlv_COLOR.xyz / ((width_5 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_8 = (t_9 * (t_9 * (3.0 - (2.0 * t_9))));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6, retColor_1, vec4(min (min (tmpvar_8.x, tmpvar_8.y), tmpvar_8.z)));
  srcColor_4 = tmpvar_10;
  retColor_1 = srcColor_4;
  gl_FragData[0] = srcColor_4;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  mediump float tmpvar_4;
  tmpvar_4 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_4;
  lowp vec4 srcColor_5;
  mediump vec3 width_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_6 = tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 t_10;
  t_10 = max (min ((xlv_COLOR.xyz / ((width_6 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_9 = (t_10 * (t_10 * (3.0 - (2.0 * t_10))));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, retColor_1, vec4(min (min (tmpvar_9.x, tmpvar_9.y), tmpvar_9.z)));
  srcColor_5 = tmpvar_11;
  retColor_1 = srcColor_5;
  gl_FragData[0] = srcColor_5;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  retColor_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  mediump float tmpvar_3;
  tmpvar_3 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_3;
  lowp vec4 srcColor_4;
  mediump vec3 width_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 t_9;
  t_9 = max (min ((xlv_COLOR.xyz / ((width_5 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_8 = (t_9 * (t_9 * (3.0 - (2.0 * t_9))));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6, retColor_1, vec4(min (min (tmpvar_8.x, tmpvar_8.y), tmpvar_8.z)));
  srcColor_4 = tmpvar_10;
  retColor_1 = srcColor_4;
  _glesFragData[0] = srcColor_4;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  float value_5;
  vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  value_5 = 1.0;
  float tmpvar_7;
  tmpvar_7 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_7 < V_WIRE_SIZE)) {
    value_5 = 0.0;
  };
  vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, retColor_1, vec4(value_5));
  retColor_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  lowp vec4 srcColor_4;
  srcColor_4 = retColor_1;
  mediump float value_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  value_5 = 1.0;
  lowp float tmpvar_7;
  tmpvar_7 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_7 < V_WIRE_SIZE)) {
    value_5 = 0.0;
  };
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, retColor_1, vec4(value_5));
  srcColor_4 = tmpvar_8;
  retColor_1 = srcColor_4;
  gl_FragData[0] = srcColor_4;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  lowp vec4 srcColor_5;
  srcColor_5 = retColor_1;
  mediump float value_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  value_6 = 1.0;
  lowp float tmpvar_8;
  tmpvar_8 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_8 < V_WIRE_SIZE)) {
    value_6 = 0.0;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, retColor_1, vec4(value_6));
  srcColor_5 = tmpvar_9;
  retColor_1 = srcColor_5;
  gl_FragData[0] = srcColor_5;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  lowp vec4 srcColor_4;
  srcColor_4 = retColor_1;
  mediump float value_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  value_5 = 1.0;
  lowp float tmpvar_7;
  tmpvar_7 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_7 < V_WIRE_SIZE)) {
    value_5 = 0.0;
  };
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, retColor_1, vec4(value_5));
  srcColor_4 = tmpvar_8;
  retColor_1 = srcColor_4;
  _glesFragData[0] = srcColor_4;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  float value_5;
  vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  value_5 = 1.0;
  float tmpvar_7;
  tmpvar_7 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_7 < V_WIRE_SIZE)) {
    value_5 = 0.0;
  };
  vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, retColor_1, vec4(value_5));
  retColor_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
// Stats: 16 math
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  mediump float tmpvar_4;
  tmpvar_4 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_4;
  lowp vec4 srcColor_5;
  srcColor_5 = retColor_1;
  mediump float value_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  value_6 = 1.0;
  lowp float tmpvar_8;
  tmpvar_8 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_8 < V_WIRE_SIZE)) {
    value_6 = 0.0;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, retColor_1, vec4(value_6));
  srcColor_5 = tmpvar_9;
  retColor_1 = srcColor_5;
  gl_FragData[0] = srcColor_5;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  mediump float tmpvar_5;
  tmpvar_5 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_5;
  lowp vec4 srcColor_6;
  srcColor_6 = retColor_1;
  mediump float value_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_8;
  value_7 = 1.0;
  lowp float tmpvar_9;
  tmpvar_9 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_9 < V_WIRE_SIZE)) {
    value_7 = 0.0;
  };
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, retColor_1, vec4(value_7));
  srcColor_6 = tmpvar_10;
  retColor_1 = srcColor_6;
  gl_FragData[0] = srcColor_6;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  mediump float tmpvar_4;
  tmpvar_4 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_4;
  lowp vec4 srcColor_5;
  srcColor_5 = retColor_1;
  mediump float value_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  value_6 = 1.0;
  lowp float tmpvar_8;
  tmpvar_8 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_8 < V_WIRE_SIZE)) {
    value_6 = 0.0;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, retColor_1, vec4(value_6));
  srcColor_5 = tmpvar_9;
  retColor_1 = srcColor_5;
  _glesFragData[0] = srcColor_5;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  vec3 tmpvar_6;
  vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, retColor_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  retColor_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  lowp vec4 srcColor_4;
  mediump vec3 width_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 t_9;
  t_9 = max (min ((xlv_COLOR.xyz / ((width_5 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_8 = (t_9 * (t_9 * (3.0 - (2.0 * t_9))));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6, retColor_1, vec4(min (min (tmpvar_8.x, tmpvar_8.y), tmpvar_8.z)));
  srcColor_4 = tmpvar_10;
  retColor_1 = srcColor_4;
  gl_FragData[0] = srcColor_4;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  lowp vec4 srcColor_5;
  mediump vec3 width_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_6 = tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 t_10;
  t_10 = max (min ((xlv_COLOR.xyz / ((width_6 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_9 = (t_10 * (t_10 * (3.0 - (2.0 * t_10))));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, retColor_1, vec4(min (min (tmpvar_9.x, tmpvar_9.y), tmpvar_9.z)));
  srcColor_5 = tmpvar_11;
  retColor_1 = srcColor_5;
  gl_FragData[0] = srcColor_5;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  lowp vec4 srcColor_4;
  mediump vec3 width_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 t_9;
  t_9 = max (min ((xlv_COLOR.xyz / ((width_5 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_8 = (t_9 * (t_9 * (3.0 - (2.0 * t_9))));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6, retColor_1, vec4(min (min (tmpvar_8.x, tmpvar_8.y), tmpvar_8.z)));
  srcColor_4 = tmpvar_10;
  retColor_1 = srcColor_4;
  _glesFragData[0] = srcColor_4;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  vec3 tmpvar_6;
  vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, retColor_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  retColor_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
// Stats: 16 math
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  mediump float tmpvar_4;
  tmpvar_4 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_4;
  lowp vec4 srcColor_5;
  mediump vec3 width_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_6 = tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 t_10;
  t_10 = max (min ((xlv_COLOR.xyz / ((width_6 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_9 = (t_10 * (t_10 * (3.0 - (2.0 * t_10))));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, retColor_1, vec4(min (min (tmpvar_9.x, tmpvar_9.y), tmpvar_9.z)));
  srcColor_5 = tmpvar_11;
  retColor_1 = srcColor_5;
  gl_FragData[0] = srcColor_5;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  mediump float tmpvar_5;
  tmpvar_5 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_5;
  lowp vec4 srcColor_6;
  mediump vec3 width_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_7 = tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 t_11;
  t_11 = max (min ((xlv_COLOR.xyz / ((width_7 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_10 = (t_11 * (t_11 * (3.0 - (2.0 * t_11))));
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, retColor_1, vec4(min (min (tmpvar_10.x, tmpvar_10.y), tmpvar_10.z)));
  srcColor_6 = tmpvar_12;
  retColor_1 = srcColor_6;
  gl_FragData[0] = srcColor_6;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 retColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  mediump float tmpvar_4;
  tmpvar_4 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_4;
  lowp vec4 srcColor_5;
  mediump vec3 width_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_6 = tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 t_10;
  t_10 = max (min ((xlv_COLOR.xyz / ((width_6 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_9 = (t_10 * (t_10 * (3.0 - (2.0 * t_10))));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, retColor_1, vec4(min (min (tmpvar_9.x, tmpvar_9.y), tmpvar_9.z)));
  srcColor_5 = tmpvar_11;
  retColor_1 = srcColor_5;
  _glesFragData[0] = srcColor_5;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  float value_2;
  vec4 tmpvar_3;
  tmpvar_3 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_2 = 1.0;
  float tmpvar_4;
  tmpvar_4 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_4 < V_WIRE_SIZE)) {
    value_2 = 0.0;
  };
  gl_FragData[0] = mix (tmpvar_3, tmpvar_1, vec4(value_2));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
// Stats: 5 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  srcColor_2 = tmpvar_1;
  mediump float value_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_3 = 1.0;
  lowp float tmpvar_5;
  tmpvar_5 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_5 < V_WIRE_SIZE)) {
    value_3 = 0.0;
  };
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, tmpvar_1, vec4(value_3));
  srcColor_2 = tmpvar_6;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  srcColor_2 = tmpvar_1;
  mediump float value_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_3 = 1.0;
  lowp float tmpvar_5;
  tmpvar_5 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_5 < V_WIRE_SIZE)) {
    value_3 = 0.0;
  };
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, tmpvar_1, vec4(value_3));
  srcColor_2 = tmpvar_6;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
in mediump vec3 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  srcColor_2 = tmpvar_1;
  mediump float value_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_3 = 1.0;
  lowp float tmpvar_5;
  tmpvar_5 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_5 < V_WIRE_SIZE)) {
    value_3 = 0.0;
  };
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, tmpvar_1, vec4(value_3));
  srcColor_2 = tmpvar_6;
  _glesFragData[0] = srcColor_2;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  float value_2;
  vec4 tmpvar_3;
  tmpvar_3 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_3;
  value_2 = 1.0;
  float tmpvar_4;
  tmpvar_4 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_4 < V_WIRE_SIZE)) {
    value_2 = 0.0;
  };
  gl_FragData[0] = mix (tmpvar_3, tmpvar_1, vec4(value_2));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  srcColor_3 = tmpvar_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, tmpvar_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  srcColor_3 = tmpvar_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, tmpvar_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  srcColor_3 = tmpvar_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, tmpvar_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  _glesFragData[0] = srcColor_3;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  gl_FragData[0] = mix (mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), tmpvar_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
// Stats: 5 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  mediump vec3 width_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_5;
  tmpvar_5 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_3 = tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / ((width_3 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  srcColor_2 = tmpvar_8;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  mediump vec3 width_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_5;
  tmpvar_5 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_3 = tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / ((width_3 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  srcColor_2 = tmpvar_8;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
in mediump vec3 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  mediump vec3 width_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_5;
  tmpvar_5 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_3 = tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / ((width_3 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  srcColor_2 = tmpvar_8;
  _glesFragData[0] = srcColor_2;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 tmpvar_2;
  tmpvar_2 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_2;
  vec3 tmpvar_3;
  vec3 t_4;
  t_4 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_3 = (t_4 * (t_4 * (3.0 - (2.0 * t_4))));
  gl_FragData[0] = mix (tmpvar_2, tmpvar_1, vec4(min (min (tmpvar_3.x, tmpvar_3.y), tmpvar_3.z)));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, tmpvar_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, tmpvar_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, tmpvar_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  _glesFragData[0] = srcColor_3;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  float value_2;
  vec4 tmpvar_3;
  tmpvar_3 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_2 = 1.0;
  float tmpvar_4;
  tmpvar_4 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_4 < V_WIRE_SIZE)) {
    value_2 = 0.0;
  };
  gl_FragData[0] = mix (tmpvar_3, tmpvar_1, vec4(value_2));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
// Stats: 5 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  srcColor_2 = tmpvar_1;
  mediump float value_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_3 = 1.0;
  lowp float tmpvar_5;
  tmpvar_5 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_5 < V_WIRE_SIZE)) {
    value_3 = 0.0;
  };
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, tmpvar_1, vec4(value_3));
  srcColor_2 = tmpvar_6;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  srcColor_2 = tmpvar_1;
  mediump float value_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_3 = 1.0;
  lowp float tmpvar_5;
  tmpvar_5 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_5 < V_WIRE_SIZE)) {
    value_3 = 0.0;
  };
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, tmpvar_1, vec4(value_3));
  srcColor_2 = tmpvar_6;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
in mediump vec3 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  srcColor_2 = tmpvar_1;
  mediump float value_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  value_3 = 1.0;
  lowp float tmpvar_5;
  tmpvar_5 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_5 < V_WIRE_SIZE)) {
    value_3 = 0.0;
  };
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, tmpvar_1, vec4(value_3));
  srcColor_2 = tmpvar_6;
  _glesFragData[0] = srcColor_2;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  float value_2;
  vec4 tmpvar_3;
  tmpvar_3 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_3;
  value_2 = 1.0;
  float tmpvar_4;
  tmpvar_4 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_4 < V_WIRE_SIZE)) {
    value_2 = 0.0;
  };
  gl_FragData[0] = mix (tmpvar_3, tmpvar_1, vec4(value_2));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  srcColor_3 = tmpvar_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, tmpvar_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  srcColor_3 = tmpvar_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, tmpvar_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  srcColor_3 = tmpvar_1;
  mediump float value_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  value_4 = 1.0;
  lowp float tmpvar_6;
  tmpvar_6 = min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z);
  if ((tmpvar_6 < V_WIRE_SIZE)) {
    value_4 = 0.0;
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, tmpvar_1, vec4(value_4));
  srcColor_3 = tmpvar_7;
  _glesFragData[0] = srcColor_3;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  gl_FragData[0] = mix (mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), tmpvar_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
// Stats: 5 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  mediump vec3 width_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_5;
  tmpvar_5 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_3 = tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / ((width_3 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  srcColor_2 = tmpvar_8;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  mediump vec3 width_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_5;
  tmpvar_5 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_3 = tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / ((width_3 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  srcColor_2 = tmpvar_8;
  gl_FragData[0] = srcColor_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
in mediump vec3 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  lowp vec4 srcColor_2;
  mediump vec3 width_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww);
  lowp vec3 tmpvar_5;
  tmpvar_5 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_3 = tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 t_7;
  t_7 = max (min ((xlv_COLOR.xyz / ((width_3 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_6 = (t_7 * (t_7 * (3.0 - (2.0 * t_7))));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z)));
  srcColor_2 = tmpvar_8;
  _glesFragData[0] = srcColor_2;
}



#endif"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 tmpvar_2;
  tmpvar_2 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_2;
  vec3 tmpvar_3;
  vec3 t_4;
  t_4 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_3 = (t_4 * (t_4 * (3.0 - (2.0 * t_4))));
  gl_FragData[0] = mix (tmpvar_2, tmpvar_1, vec4(min (min (tmpvar_3.x, tmpvar_3.y), tmpvar_3.z)));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, tmpvar_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

#extension GL_OES_standard_derivatives : enable
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, tmpvar_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  gl_FragData[0] = srcColor_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump float xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 objSpaceCameraPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((_World2Object * tmpvar_3).xyz * unity_Scale.w);
  objSpaceCameraPos_2 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD3 = (1.0 - dot (normalize(_glesNormal), normalize((objSpaceCameraPos_2 - _glesVertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 V_WIRE_COLOR;
uniform mediump float V_WIRE_SIZE;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
lowp vec4 xlat_mutableV_WIRE_COLOR;
in mediump vec3 xlv_TEXCOORD0;
in mediump float xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture (_MainTex, xlv_TEXCOORD0.xy));
  mediump float tmpvar_2;
  tmpvar_2 = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  xlat_mutableV_WIRE_COLOR.w = tmpvar_2;
  lowp vec4 srcColor_3;
  mediump vec3 width_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz)));
  width_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 t_8;
  t_8 = max (min ((xlv_COLOR.xyz / ((width_4 * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_7 = (t_8 * (t_8 * (3.0 - (2.0 * t_8))));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, tmpvar_1, vec4(min (min (tmpvar_7.x, tmpvar_7.y), tmpvar_7.z)));
  srcColor_3 = tmpvar_9;
  _glesFragData[0] = srcColor_3;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 12 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
texld r1, v1, s1
texld r0, v0, s0
min_pp r2.x, v2, v2.y
min_pp r2.x, r2, v2.z
add_pp r2.x, r2, -c1
mul_pp r0, r0, c2
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c3.x
add_pp r1, -r0, c0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 11 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedonfhodngfbcfdmhbjmoamaiaaojfampiabaaaaaaeiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajpcaabaaa
aaaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaaddaaaaahbcaabaaaacaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaa
ddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaackbabaaaadaaaaaadbaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaabaaaaaadhaaaaaj
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 15 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
texld r1, v1, s1
texld r0, v0, s0
min_pp r2.y, v3.x, v3
mul_pp r0, r0, c2
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0
mul_pp r2.x, v2, c0.w
mul_pp r0.xyz, r0, c3.x
mov_pp r1.w, r2.x
mov_pp r1.xyz, c0
add_pp r1, r1, -r0
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v3.z
add_pp r2.x, r2.y, -c1
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 13 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedihknjandnhbcgmgjonedekmpopahejejabaaaaaaneadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
laacaaaaeaaaaaaakmaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaibcaabaaa
aaaaaaaackbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalicaabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaackbabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaia
ebaaaaaaaaaaaaaaegaobaaaabaaaaaaddaaaaahbcaabaaaacaaaaaabkbabaaa
aeaaaaaaakbabaaaaeaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
ckbabaaaaeaaaaaadbaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaabaaaaaadhaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 26 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
texld r1, v1, s1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
mul_pp r1.xyz, r1.w, r1
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r0.xyz, v2, r0
mul_pp r2.xyz, r0, r0
mad_pp r3.xyz, -r0, c3.z, c3.w
mul_pp r2.xyz, r2, r3
texld r0, v0, s0
mul_pp r0, r0, c2
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c3.x
add_pp r1, -r0, c0
mul_pp r1, r1, c0.w
min_pp r2.x, r2, r2.y
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 20 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjafbemgeebokbakaigechjhjofpabanhabaaaaaafaaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcfmadaaaaeaaaaaaanhaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaaf
hcaabaaaaaaaaaaaegbcbaaaadaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaa
adaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaakaebaaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaa
dcaaaaakpcaabaaaacaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 29 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
dsy_pp r0.xyz, v3
dsx_pp r1.xyz, v3
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r2.xyz, r0, c3.y
texld r1, v1, s1
texld r0, v0, s0
mul_pp r1.xyz, r1.w, r1
mul_pp r0, r0, c2
mul_pp r0.xyz, r1, r0
mul_pp r2.w, v2.x, c0
rcp_pp r1.x, r2.x
rcp_pp r1.z, r2.z
rcp_pp r1.y, r2.y
mul_pp_sat r2.xyz, v3, r1
mad_pp r3.xyz, -r2, c3.z, c3.w
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0.xyz, r0, c3.x
mov_pp r1.xyz, c0
mov_pp r1.w, r2
add_pp r1, r1, -r0
mul_pp r1, r2.w, r1
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 22 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkamhpegpgknacgfkckifpkhhbfneoeamabaaaaaanmaeaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
liadaaaaeaaaaaaaooaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaackbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaal
hcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaalicaabaaaadaaaaaadkiacaaaaaaaaaaaaaaaaaaackbabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 14 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
texld r0, v0, s0
min_pp r2.x, v2, v2.y
min_pp r2.x, r2, v2.z
add_pp r2.x, r2, -c1
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1, c0
mov_pp r1.w, c0
add_pp r1, r1, -r0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 12 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkifkbiolbjkkpenlgbogdhheijhaoapaabaaaaaahmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefciiacaaaaeaaaaaaakcaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaagicaabaaa
abaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaapgipcaaa
aaaaaaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaacaaaaaaddaaaaahbcaabaaa
acaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaackbabaaaadaaaaaadbaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakiacaaaaaaaaaaaabaaaaaadhaaaaajbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajpccabaaaaaaaaaaa
agaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 15 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
mul_pp r2.x, v2, c0.w
texld r0, v0, s0
min_pp r2.y, v3.x, v3
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mov_pp r1.w, r2.x
mul_pp r1.xyz, r1, c0
add_pp r1, r1, -r0
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v3.z
add_pp r2.x, r2.y, -c1
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 13 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedelbblncanmcnfppepahfcmdobhjjmenjabaaaaaalmadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jiacaaaaeaaaaaaakgaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaiicaabaaaabaaaaaa
ckbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaa
pgapbaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaacaaaaaaddaaaaahbcaabaaa
acaaaaaabkbabaaaaeaaaaaaakbabaaaaeaaaaaaddaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaackbabaaaaeaaaaaadbaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakiacaaaaaaaaaaaabaaaaaadhaaaaajbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajpccabaaaaaaaaaaa
agaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 28 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v2, r0
mad_pp r3.xyz, -r2, c3.z, c3.w
texld r0, v0, s0
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1, c0
mov_pp r1.w, c0
add_pp r1, r1, -r0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 21 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkijhdpknlpjggdkgfndjbnadnnhaobbeabaaaaaaieaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaaoeaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaaf
hcaabaaaaaaaaaaaegbcbaaaadaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaa
adaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaakaebaaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaag
icaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 29 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
dsy_pp r0.xyz, v3
dsx_pp r1.xyz, v3
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
mul_pp r2.w, v2.x, c0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v3, r0
mad_pp r3.xyz, -r2, c3.z, c3.w
texld r0, v0, s0
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1, c0
mov_pp r1.w, r2
add_pp r1, r1, -r0
mul_pp r1, r2.w, r1
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 22 math, 2 textures
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedknaagfjbaiganaikfbgphkjfhcoaggecabaaaaaameaeaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
kaadaaaaeaaaaaaaoiaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
ocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaiicaabaaa
abaaaaaackbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaapgapbaaaabaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 9 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_color0 v1.xyz
min_pp r2.x, v1, v1.y
min_pp r2.x, r2, v1.z
add_pp r2.x, r2, -c1
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 8 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmdjaneioopghpnjnnbpdjnmdbdffnopcabaaaaaakiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmabaaaaeaaaaaaa
hdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaah
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaaaacaaaaaadbaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaam
pcaabaaaadaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaaaaaaaaadcaaaaakpcaabaaaacaaaaaapgipcaaaaaaaaaaa
aaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 11 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.x, v1, c0.w
min_pp r2.y, v2.x, v2
texld r0, v0, s0
mov_pp r1.w, r2.x
mov_pp r1.xyz, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v2.z
add_pp r2.x, r2.y, -c1
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlfgbdlhejnilceolmjhfffmhjendggdhabaaaaaacmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefccaacaaaaeaaaaaaaiiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaadaaaaaadbaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaaaaaaaaa
dkbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaaaaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaacaaaaaadcaaaaalicaabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaalpcaabaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 23 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
dcl_color0 v1.xyz
dsy_pp r0.xyz, v1
dsx_pp r1.xyz, v1
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v1, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 17 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedembjogifofeddngbggjcfndfehmabpdiabaaaaaalaadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneacaaaaeaaaaaaa
lfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaaf
hcaabaaaaaaaaaaaegbcbaaaacaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaa
acaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaakaebaaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadcaaaaampcaabaaaadaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadcaaaaakpcaabaaaacaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 25 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.w, v1.x, c0
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v2, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1.xyz, c0
mov_pp r1.w, r2
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.w, r1
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 19 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefieceddfihpphepdebbghpegipoakagdohjpfpabaaaaaadeaeaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcciadaaaaeaaaaaaamkaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaadaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaadaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaadkbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaalicaabaaaacaaaaaadkiacaaa
aaaaaaaaaaaaaaaadkbabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaadcaaaaaj
pcaabaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 9 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_color0 v1.xyz
min_pp r2.x, v1, v1.y
min_pp r2.x, r2, v1.z
add_pp r2.x, r2, -c1
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 8 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmdjaneioopghpnjnnbpdjnmdbdffnopcabaaaaaakiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmabaaaaeaaaaaaa
hdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaah
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaaaacaaaaaadbaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaam
pcaabaaaadaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaaaaaaaaadcaaaaakpcaabaaaacaaaaaapgipcaaaaaaaaaaa
aaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 11 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.x, v1, c0.w
min_pp r2.y, v2.x, v2
texld r0, v0, s0
mov_pp r1.w, r2.x
mov_pp r1.xyz, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v2.z
add_pp r2.x, r2.y, -c1
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlfgbdlhejnilceolmjhfffmhjendggdhabaaaaaacmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefccaacaaaaeaaaaaaaiiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaadaaaaaadbaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaaaaaaaaa
dkbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaaaaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaacaaaaaadcaaaaalicaabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaalpcaabaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 23 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
dcl_color0 v1.xyz
dsy_pp r0.xyz, v1
dsx_pp r1.xyz, v1
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v1, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 17 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedembjogifofeddngbggjcfndfehmabpdiabaaaaaalaadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneacaaaaeaaaaaaa
lfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaaf
hcaabaaaaaaaaaaaegbcbaaaacaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaa
acaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaakaebaaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadcaaaaampcaabaaaadaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadcaaaaakpcaabaaaacaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 25 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.w, v1.x, c0
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v2, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1.xyz, c0
mov_pp r1.w, r2
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.w, r1
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 19 math, 1 textures
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefieceddfihpphepdebbghpegipoakagdohjpfpabaaaaaadeaeaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcciadaaaaeaaaaaaamkaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaadaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaadaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaadkbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaalicaabaaaacaaaaaadkiacaaa
aaaaaaaaaaaaaaaadkbabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaadcaaaaaj
pcaabaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLES3"
}
}
 }
}
}