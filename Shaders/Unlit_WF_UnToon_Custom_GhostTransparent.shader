﻿/*
 *  The MIT License
 *
 *  Copyright 2018-2021 whiteflare.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 *  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 *  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 *  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
Shader "UnlitWF/Custom/WF_UnToon_Custom_GhostTransparent" {

    Properties {
        // 基本
        [WFHeader(Base)]
            _MainTex                ("Main Texture", 2D) = "white" {}
        [HDR]
            _Color                  ("Color", Color) = (1, 1, 1, 1)
        [Toggle(_)]
            _UseVertexColor         ("Use Vertex Color", Range(0, 1)) = 0

        // Alpha
        [WFHeader(Transparent Alpha)]
        [Enum(MAIN_TEX_ALPHA,0,MASK_TEX_RED,1,MASK_TEX_ALPHA,2)]
            _AL_Source              ("[AL] Alpha Source", Float) = 0
        [NoScaleOffset]
            _AL_MaskTex             ("[AL] Alpha Mask Texture", 2D) = "white" {}
        [Toggle(_)]
            _AL_InvMaskVal          ("[AL] Invert Mask Value", Range(0, 1)) = 0
            _AL_Power               ("[AL] Power", Range(0, 2)) = 1.0
            _AL_Fresnel             ("[AL] Fresnel Power", Range(0, 2)) = 0

        // 裏面テクスチャ
        [WFHeaderToggle(BackFace Texture)]
            _BK_Enable              ("[BK] Enable", Float) = 0
            _BK_BackTex             ("[BK] Back Texture", 2D) = "white" {}
        [HDR]
            _BK_BackColor           ("[BK] Back Color", Color) = (1, 1, 1, 1)

        // 3chカラーマスク
        [WFHeaderToggle(3ch Color Mask)]
            _CH_Enable              ("[CH] Enable", Float) = 0
        [NoScaleOffset]
            _CH_3chMaskTex          ("[CH] 3ch Mask Texture", 2D) = "black" {}
        [HDR]
            _CH_ColorR              ("[CH] R ch Color", Color) = (1, 1, 1, 1)
        [HDR]
            _CH_ColorG              ("[CH] G ch Color", Color) = (1, 1, 1, 1)
        [HDR]
            _CH_ColorB              ("[CH] B ch Color", Color) = (1, 1, 1, 1)

        // 色変換
        [WFHeaderToggle(Color Change)]
            _CL_Enable              ("[CL] Enable", Float) = 0
        [Toggle(_)]
            _CL_Monochrome          ("[CL] monochrome", Range(0, 1)) = 0
            _CL_DeltaH              ("[CL] Hur", Range(0, 1)) = 0
            _CL_DeltaS              ("[CL] Saturation", Range(-1, 1)) = 0
            _CL_DeltaV              ("[CL] Brightness", Range(-1, 1)) = 0

        // 法線マップ
        [WFHeaderToggle(NormalMap)]
            _NM_Enable              ("[NM] Enable", Float) = 0
        [NoScaleOffset]
            _BumpMap                ("[NM] NormalMap Texture", 2D) = "bump" {}
            _BumpScale              ("[NM] Bump Scale", Range(0, 2)) = 1.0
            _NM_Power               ("[NM] Shadow Power", Range(0, 1)) = 0.25
        [Enum(NONE,0,X,1,Y,2,XY,3)]
            _NM_FlipMirror          ("[NM] Flip Mirror", Float) = 0

        [Header(NormalMap Secondary)]
        [Enum(OFF,0,BLEND,1,SWITCH,2)]
            _NM_2ndType             ("[NM] 2nd Normal Blend", Float) = 0
            _DetailNormalMap        ("[NM] 2nd NormalMap Texture", 2D) = "bump" {}
            _DetailNormalMapScale   ("[NM] 2nd Bump Scale", Range(0, 2)) = 0.4
        [NoScaleOffset]
            _NM_2ndMaskTex          ("[NM] 2nd NormalMap Mask Texture (R)", 2D) = "white" {}
        [Toggle(_)]
            _NM_InvMaskVal          ("[NM] Invert Mask Value", Range(0, 1)) = 0

        // メタリックマップ
        [WFHeaderToggle(Metallic)]
            _MT_Enable              ("[MT] Enable", Float) = 0
            _MT_Metallic            ("[MT] Metallic", Range(0, 1)) = 1
            _MT_ReflSmooth          ("[MT] Smoothness", Range(0, 1)) = 1
            _MT_Brightness          ("[MT] Brightness", Range(0, 1)) = 0.2
            _MT_BlendNormal         ("[MT] Blend Normal", Range(0, 1)) = 0.1
            _MT_Monochrome          ("[MT] Monochrome Reflection", Range(0, 1)) = 0
        [Toggle(_)]
            _MT_GeomSpecAA          ("[MT] Geometric Specular AA", Range(0, 1)) = 1
        [Enum(MASK,0,METALLIC,1)]
            _MT_MetallicMapType     ("[MT] MetallicMap Type", Float) = 0
        [NoScaleOffset]
            _MetallicGlossMap       ("[MT] MetallicSmoothnessMap Texture", 2D) = "white" {}
        [Toggle(_)]
            _MT_InvMaskVal          ("[MT] Invert Mask Value", Range(0, 1)) = 0
        [NoScaleOffset]
            _SpecGlossMap           ("[MT] RoughnessMap Texture", 2D) = "black" {}
        [Toggle(_)]
            _MT_InvRoughnessMaskVal ("[MT] Invert Mask Value", Range(0, 1)) = 0

        [Header(Metallic Specular)]
            _MT_Specular            ("[MT] Specular", Range(0, 1)) = 0
            _MT_SpecSmooth          ("[MT] Smoothness", Range(0, 1)) = 0.8

        [Header(Metallic Secondary)]
        [Enum(OFF,0,ADDITION,1,ONLY_SECOND_MAP,2)]
            _MT_CubemapType         ("[MT] 2nd CubeMap Blend", Float) = 0
        [NoScaleOffset]
            _MT_Cubemap             ("[MT] 2nd CubeMap", Cube) = "" {}
            _MT_CubemapPower        ("[MT] 2nd CubeMap Power", Range(0, 2)) = 1
            _MT_CubemapHighCut      ("[MT] 2nd CubeMap Hi-Cut Filter", Range(0, 1)) = 0

        // Matcapハイライト
        [WFHeaderToggle(Light Matcap)]
            _HL_Enable              ("[HL] Enable", Float) = 0
        [Enum(MEDIAN_CAP,0,LIGHT_CAP,1,SHADE_CAP,2)]
            _HL_CapType             ("[HL] Matcap Type", Float) = 0
        [NoScaleOffset]
            _HL_MatcapTex           ("[HL] Matcap Sampler", 2D) = "gray" {}
            _HL_MedianColor         ("[HL] Matcap Base Color", Color) = (0.5, 0.5, 0.5, 1)
            _HL_Power               ("[HL] Power", Range(0, 2)) = 1
            _HL_BlendNormal         ("[HL] Blend Normal", Range(0, 1)) = 0.1
            _HL_Parallax            ("[HL] Parallax", Range(0, 1)) = 0.75
        [Toggle(_)]
            _HL_ChangeAlpha         ("[HL] Change Alpha Transparency", Range(0, 1)) = 0
        [NoScaleOffset]
            _HL_MaskTex             ("[HL] Mask Texture (RGB)", 2D) = "white" {}
        [Toggle(_)]
            _HL_InvMaskVal          ("[HL] Invert Mask Value", Range(0, 1)) = 0
            _HL_MatcapColor         ("[HL] Matcap Tint Color", Color) = (0.5, 0.5, 0.5, 1)

        // 階調影
        [WFHeaderToggle(ToonShade)]
            _TS_Enable              ("[SH] Enable", Float) = 0
        [IntRange]
            _TS_Steps               ("[SH] Steps", Range(1, 3)) = 2
            _TS_BaseColor           ("[SH] Base Color", Color) = (1, 1, 1, 1)
        [NoScaleOffset]
            _TS_BaseTex             ("[SH] Base Shade Texture", 2D) = "white" {}
            _TS_1stColor            ("[SH] 1st Shade Color", Color) = (0.81, 0.81, 0.9, 1)
        [NoScaleOffset]
            _TS_1stTex              ("[SH] 1st Shade Texture", 2D) = "white" {}
            _TS_2ndColor            ("[SH] 2nd Shade Color", Color) = (0.68, 0.68, 0.8, 1)
        [NoScaleOffset]
            _TS_2ndTex              ("[SH] 2nd Shade Texture", 2D) = "white" {}
            _TS_3rdColor            ("[SH] 3rd Shade Color", Color) = (0.595, 0.595, 0.7, 1)
        [NoScaleOffset]
            _TS_3rdTex              ("[SH] 3rd Shade Texture", 2D) = "white" {}
            _TS_Power               ("[SH] Shade Power", Range(0, 2)) = 1
            _TS_1stBorder           ("[SH] 1st Border", Range(0, 1)) = 0.4
            _TS_2ndBorder           ("[SH] 2nd Border", Range(0, 1)) = 0.2
            _TS_3rdBorder           ("[SH] 3rd Border", Range(0, 1)) = 0.1
            _TS_Feather             ("[SH] Feather", Range(0, 0.2)) = 0.05
            _TS_BlendNormal         ("[SH] Blend Normal", Range(0, 1)) = 0.1
        [NoScaleOffset]
            _TS_MaskTex             ("[SH] Anti-Shadow Mask Texture (R)", 2D) = "black" {}
        [Toggle(_)]
            _TS_InvMaskVal          ("[SH] Invert Mask Value", Range(0, 1)) = 0

        // リムライト
        [WFHeaderToggle(RimLight)]
            _TR_Enable              ("[RM] Enable", Float) = 0
        [HDR]
            _TR_Color               ("[RM] Rim Color", Color) = (0.8, 0.8, 0.8, 1)
        [Enum(ADD,2,ALPHA,1,ADD_AND_SUB,0)]
            _TR_BlendType           ("[RM] Blend Type", Float) = 0
            _TR_Power               ("[RM] Power", Range(0, 2)) = 1
            _TR_Feather             ("[RM] Feather", Range(0, 0.2)) = 0.05
            _TR_BlendNormal         ("[RM] Blend Normal", Range(0, 1)) = 0
        [NoScaleOffset]
            _TR_MaskTex             ("[RM] Mask Texture (RGB)", 2D) = "white" {}
        [Toggle(_)]
            _TR_InvMaskVal          ("[RM] Invert Mask Value", Range(0, 1)) = 0
        [Header(RimLight Advance)]
            _TR_PowerTop            ("[RM] Power Top", Range(0, 0.5)) = 0.1
            _TR_PowerSide           ("[RM] Power Side", Range(0, 0.5)) = 0.1
            _TR_PowerBottom         ("[RM] Power Bottom", Range(0, 0.5)) = 0.1

        // Overlay Texture
        [WFHeaderToggle(Overlay Texture)]
            _OL_Enable              ("[OL] Enable", Float) = 0
        [Enum(UV1,0,UV2,1,SKYBOX,2,MATCAP,4,ANGEL_RING,3)]
            _OL_UVType              ("[OL] UV Type", Float) = 0
        [HDR]
            _OL_Color               ("[OL] Overlay Color", Color) = (1, 1, 1, 1)
            _OL_OverlayTex          ("[OL] Overlay Texture", 2D) = "white" {}
        [WF_Vector2]
            _OL_UVScroll            ("[OL] UV Scroll", Vector) = (0, 0, 0, 0)
        [Toggle(_)]
            _OL_VertColToDecal      ("[OL] Multiply VertexColor To Overlay Texture", Range(0, 1)) = 0
        [Enum(ALPHA,0,ADD,1,MUL,2,ADD_AND_SUB,3,SCREEN,4,OVERLAY,5,HARD_LIGHT,6)]
            _OL_BlendType           ("[OL] Blend Type", Float) = 0
            _OL_Power               ("[OL] Blend Power", Range(0, 1)) = 1
            _OL_CustomParam1        ("[OL] Customize Parameter 1", Range(0, 1)) = 0
        [NoScaleOffset]
            _OL_MaskTex             ("[OL] Mask Texture (R)", 2D) = "white" {}
        [Toggle(_)]
            _OL_VertColToMask       ("[OL] Multiply VertexColor To Mask Texture", Range(0, 1)) = 0
        [Toggle(_)]
            _OL_InvMaskVal          ("[OL] Invert Mask Value", Range(0, 1)) = 0

        // Ambient Occlusion
        [WFHeaderToggle(Ambient Occlusion)]
            _AO_Enable              ("[AO] Enable", Float) = 0
        [Enum(UV1,0,UV2,1)]
            _AO_UVType              ("[AO] UV Type", Float) = 0
        [NoScaleOffset]
            _OcclusionMap           ("[AO] Occlusion Map (RGB)", 2D) = "white" {}
        [Toggle(_)]
            _AO_UseGreenMap         ("[AO] Use Green Channel Only", Float) = 0
            _AO_TintColor           ("[AO] Tint Color", Color) = (0, 0, 0, 1)
        [Toggle(_)]
            _AO_UseLightMap         ("[AO] Use LightMap", Float) = 1
            _AO_Contrast            ("[AO] Contrast", Range(0, 2)) = 1
            _AO_Brightness          ("[AO] Brightness", Range(-1, 1)) = 0

        // Emission
        [WFHeaderToggle(Emission)]
            _ES_Enable              ("[ES] Enable", Float) = 0
        [HDR]
            _EmissionColor          ("[ES] Emission", Color) = (1, 1, 1, 1)
        [NoScaleOffset]
            _EmissionMap            ("[ES] Emission Texture", 2D) = "white" {}
        [Enum(ADD,0,ALPHA,2,LEGACY_ALPHA,1)]
            _ES_BlendType           ("[ES] Blend Type", Float) = 0

        [Header(Emissive Scroll)]
        [Enum(STANDARD,0,SAWTOOTH,1,SIN_WAVE,2,CONSTANT,3)]
            _ES_Shape               ("[ES] Wave Type", Float) = 3
        [Toggle(_)]
            _ES_AlphaScroll         ("[ES] Change Alpha Transparency", Range(0, 1)) = 0
        [Enum(WORLD_SPACE,0,LOCAL_SPACE,1,UV1,2,UV2,3)]
            _ES_DirType             ("[ES] Direction Type", Float) = 0
        [WF_Vector3]
            _ES_Direction           ("[ES] Direction", Vector) = (0, -10, 0, 0)
            _ES_LevelOffset         ("[ES] LevelOffset", Range(-1, 1)) = 0
            _ES_Sharpness           ("[ES] Sharpness", Range(0, 4)) = 1
            _ES_Speed               ("[ES] ScrollSpeed", Range(0, 8)) = 2

        // Lit
        [WFHeader(Lit)]
        [Gamma]
            _GL_LevelMin            ("Unlit Intensity", Range(0, 1)) = 0.125
        [Gamma]
            _GL_LevelMax            ("Saturate Intensity", Range(0, 1)) = 0.8
            _GL_BlendPower          ("Chroma Reaction", Range(0, 1)) = 0.8
        [Toggle(_)]
            _GL_CastShadow          ("Cast Shadows", Range(0, 1)) = 1

        [WFHeader(Lit Advance)]
        [Enum(AUTO,0,ONLY_DIRECTIONAL_LIT,1,ONLY_POINT_LIT,2,CUSTOM_WORLDSPACE,3,CUSTOM_LOCALSPACE,4)]
            _GL_LightMode           ("Sun Source", Float) = 0
            _GL_CustomAzimuth       ("Custom Sun Azimuth", Range(0, 360)) = 0
            _GL_CustomAltitude      ("Custom Sun Altitude", Range(-90, 90)) = 45
        [Toggle(_)]
            _GL_DisableBackLit      ("Disable BackLit", Range(0, 1)) = 0
        [Toggle(_)]
            _GL_DisableBasePos      ("Disable ObjectBasePos", Range(0, 1)) = 0

        [WFHeaderToggle(Light Bake Effects)]
            _GI_Enable              ("[GI] Enable", Float) = 0
            _GI_IndirectMultiplier  ("[GI] Indirect Multiplier", Range(0, 2)) = 1
            _GI_EmissionMultiplier  ("[GI] Emission Multiplier", Range(0, 2)) = 1
            _GI_IndirectChroma      ("[GI] Indirect Chroma", Range(0, 2)) = 1

        [HideInInspector]
        [WF_FixFloat(0.0)]
            _CurrentVersion         ("2021/12/04", Float) = 0
        [HideInInspector]
        [WF_FixFloat(0.0)]
            _FallBack               ("UnlitWF/UnToon_Mobile/WF_UnToon_Mobile_Transparent", Float) = 0
    }

    SubShader {
        Tags {
            "RenderType" = "Transparent"
            "Queue" = "Transparent+450"
            "VRCFallback" = "UnlitTransparent"
        }

        Pass {
            Tags { "LightMode" = "ForwardBase" }
            ColorMask 0
            Cull OFF
            ZWrite ON
        }

        Pass {
            Name "MAIN_BACK"
            Tags { "LightMode" = "ForwardBase" }

            Cull FRONT
            ZWrite OFF
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #pragma target 4.5

            #define _WF_ALPHA_FRESNEL
            #define _WF_FACE_BACK

            #pragma shader_feature_local _AO_ENABLE
            #pragma shader_feature_local _NM_ENABLE
            #pragma shader_feature_local _OL_ENABLE
            #pragma shader_feature_local _TS_ENABLE
            #pragma shader_feature_local _VC_ENABLE
            #pragma shader_feature_local_fragment _ _ES_SCROLL_ENABLE
            #pragma shader_feature_local_fragment _ _MT_ADD2ND_ENABLE _MT_ONLY2ND_ENABLE
            #pragma shader_feature_local_fragment _ _NM_BL2ND_ENABLE _NM_SW2ND_ENABLE
            #pragma shader_feature_local_fragment _ _TS_STEP1_ENABLE _TS_STEP2_ENABLE _TS_STEP3_ENABLE
            #pragma shader_feature_local_fragment _BK_ENABLE
            #pragma shader_feature_local_fragment _CH_ENABLE
            #pragma shader_feature_local_fragment _CL_ENABLE
            #pragma shader_feature_local_fragment _ES_ENABLE
            #pragma shader_feature_local_fragment _HL_ENABLE
            #pragma shader_feature_local_fragment _MT_ENABLE
            #pragma shader_feature_local_fragment _TR_ENABLE

            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma multi_compile_instancing

            #pragma skip_variants SHADOWS_SCREEN SHADOWS_CUBE SHADOWS_SHADOWMASK

            #include "WF_UnToon.cginc"

            ENDCG
        }

        Pass {
            Name "MAIN_FRONT"
            Tags { "LightMode" = "ForwardBase" }

            Cull BACK
            ZWrite OFF
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #pragma target 4.5

            #define _WF_ALPHA_FRESNEL

            #pragma shader_feature_local _AO_ENABLE
            #pragma shader_feature_local _NM_ENABLE
            #pragma shader_feature_local _OL_ENABLE
            #pragma shader_feature_local _TS_ENABLE
            #pragma shader_feature_local _VC_ENABLE
            #pragma shader_feature_local_fragment _ _ES_SCROLL_ENABLE
            #pragma shader_feature_local_fragment _ _MT_ADD2ND_ENABLE _MT_ONLY2ND_ENABLE
            #pragma shader_feature_local_fragment _ _NM_BL2ND_ENABLE _NM_SW2ND_ENABLE
            #pragma shader_feature_local_fragment _ _TS_STEP1_ENABLE _TS_STEP2_ENABLE _TS_STEP3_ENABLE
            #pragma shader_feature_local_fragment _BK_ENABLE
            #pragma shader_feature_local_fragment _CH_ENABLE
            #pragma shader_feature_local_fragment _CL_ENABLE
            #pragma shader_feature_local_fragment _ES_ENABLE
            #pragma shader_feature_local_fragment _HL_ENABLE
            #pragma shader_feature_local_fragment _MT_ENABLE
            #pragma shader_feature_local_fragment _TR_ENABLE

            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma multi_compile_instancing

            #pragma skip_variants SHADOWS_SCREEN SHADOWS_CUBE SHADOWS_SHADOWMASK

            #include "WF_UnToon.cginc"

            ENDCG
        }

        Pass {
            Name "SHADOWCASTER"
            Tags{ "LightMode" = "ShadowCaster" }

            Cull OFF

            CGPROGRAM

            #pragma vertex vert_shadow
            #pragma fragment frag_shadow

            #define _WF_ALPHA_BLEND

            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing

            #include "WF_UnToon_ShadowCaster.cginc"

            ENDCG
        }

        Pass {
            Name "META"
            Tags { "LightMode" = "Meta" }

            Cull OFF

            CGPROGRAM

            #pragma vertex vert_meta
            #pragma fragment frag_meta

            #define _WF_ALPHA_BLEND

            #pragma shader_feature_local _VC_ENABLE

            #pragma shader_feature EDITOR_VISUALIZATION

            #include "WF_UnToon_Meta.cginc"

            ENDCG
        }
    }

    FallBack "UnlitWF/UnToon_Mobile/WF_UnToon_Mobile_Transparent"

    CustomEditor "UnlitWF.ShaderCustomEditor"
}
