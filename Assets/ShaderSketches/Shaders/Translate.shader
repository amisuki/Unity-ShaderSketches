﻿Shader "ShaderSketches/Translate"
{
    Properties
    {
        _MainTex ("MainTex", 2D) = "white"{}
    }

    CGINCLUDE
    #include "UnityCG.cginc"

    float box(float2 st, float2 size)
    {
        size = 0.5 - size * 0.5;
        float2 uv = smoothstep(size, size + 0.001, st);
        uv *= smoothstep(size, size + 0.001, 1.0 - st);
        return uv.x * uv.y;
    }

    float3x3 translate(float x, float y)
    {
        return float3x3(1, 0, x,
                        0, 1, y,
                        0, 0, 1);
    }
    
    float4 frag(v2f_img i) : SV_Target
    {
        float2 st = i.uv;
        float t = _Time.y;
        
        st = mul(translate(sin(t) * 0.35,
                           cos(t) * 0.35),
                 float3(st, 1));
        
        return box(st, 0.25);
    }
    
    ENDCG

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            ENDCG
        }
    }
}
