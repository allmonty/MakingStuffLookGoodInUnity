﻿Shader "Shaders101/10_SpriteGrayAndColorTint"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"PreviewType" = "Plane"
		}

		Pass
		{
			//Documentation of Blending: https://docs.unity3d.com/Manual/SL-Blend.html
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			half4 _Color;

			float4 frag(v2f i) : SV_Target
			{
				float4 cMain = tex2D(_MainTex, i.uv);
				float luminance = 0.3*cMain.r + 0.59*cMain.g + 0.11*cMain.b;
				float4 color = float4(luminance, luminance, luminance, cMain.a);
				return color * _Color;
			}

			ENDCG
		}
	}
}