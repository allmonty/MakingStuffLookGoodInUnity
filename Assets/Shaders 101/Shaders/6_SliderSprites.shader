﻿Shader "Shaders101/06_SliderSprites"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		_Tween("Tween", Range(0, 1)) = 0
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
			sampler2D _SecondTex;
			float _Tween;

			float4 frag(v2f i) : SV_Target
			{
				float4 colorMain = tex2D(_MainTex, i.uv);
				float4 colorSecond = tex2D(_SecondTex, i.uv);
				return lerp(colorMain * colorMain.a, colorSecond * colorSecond.a, _Tween);
			}

			ENDCG
		}
	}
}