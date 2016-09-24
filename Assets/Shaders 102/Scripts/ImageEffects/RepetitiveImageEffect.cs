using UnityEngine;

[ExecuteInEditMode]
public class RepetitiveImageEffect : MonoBehaviour
{
    public Material EffectMaterial;
    [Range(0, 20)]
    public int Iterations;
    
    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        RenderTexture rt = RenderTexture.GetTemporary(src.width, src.height);

        Graphics.Blit(src, rt);

        for(int i = 0; i < Iterations; i++)
        {
            RenderTexture rt2 = RenderTexture.GetTemporary(rt.width, rt.height);
            Graphics.Blit(rt, rt2, EffectMaterial);
            RenderTexture.ReleaseTemporary(rt);
            rt = rt2;
        }

        Graphics.Blit(rt, dst);
        RenderTexture.ReleaseTemporary(rt);
    } 
}
