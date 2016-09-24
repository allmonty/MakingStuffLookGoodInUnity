Shader "Shaders102/02_TextureWithUVColor"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}

	SubShader
	{
		//No culling or depth
		Cull Off ZWrite Off ZTest Always

		Tags
		{
			"Queue" = "Transparent"
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

			float4 frag(v2f i) : SV_Target
			{
				float4 color1 = tex2D(_MainTex, i.uv);
				float4 color2 = float4(i.uv.r, i.uv.g, 0, 1);
				return color1 * color2;
			}

			ENDCG
		}
	}
}