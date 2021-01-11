---
layout: "default"
---

<!-- Blog -->
<section id="doc" class=" container text-center markdown-body comment-enabled" data-hard-breaks="true"><h1 id="Unveiling-High-level-Discriminant-Harmonic-Features-of-Musical-Style-in-the-Tonal-Interval-Space" data-id="Unveiling-High-level-Discriminant-Harmonic-Features-of-Musical-Style-in-the-Tonal-Interval-Space"><span>Unveiling High-level Discriminant Harmonic Features of Musical Style in the Tonal Interval Space</span></h1><blockquote>
<p><span>This is a supplementary material to the submission of the paper “Unveiling High-level Discriminant Harmonic Features of Musical Style in the Tonal Interval Space” to ICMPC 2021 conference.</span></p>
</blockquote><hr><p><span>In distinguishing historical times, composers, musicians, sonic texture, emotion, and genre, style is one of the most prominent musical attributes. Many musical styles have been examined in recent years for their automatic detection and synthesis of musical audio.  Most of the work focuses on low-level perceptual characteristics that do not reflect high-level chords’ characteristics and their underlying grammar.  In this project, we want to distinguish historical times of classical music (with </span><a href="https://www.audiolabs-erlangen.de/resources/MIR/cross-era" target="_blank" rel="noopener"><span>cross-era dataset</span></a><span>) understanding the harmony from an explainable musical perspective thanks to </span><a href="https://sites.google.com/site/tonalintervalspace/home" target="_blank" rel="noopener"><span>Tonal Interval Space</span></a><span> (TIV).</span></p><p><span>[Tonal Interval Space circles representation]</span></p><p><span>This circles represent several features robust to transpositions across keys.</span></p><h2 id="Descriptors" data-id="Descriptors"><span>Descriptors</span></h2><p><span>Several explainable descriptors have been computed inside the TIV. These descriptors are computed across each audio frame by frame. Then, We use the median (.med) and interquartile range (.IQR) to resume the descriptors on each audio. In the following box graph can be seen the mentioned resume descriptors distributions, feel free of clicking on each descriptor, the graph is interactive!</span></p><p><span>[Interactive box graph]</span></p><p><span>In the following section are explained each descriptor in detail:</span></p><ul>
<li>
<p><strong><span>Dissonance (diss):</span></strong><span> It provides a measure of dissonance (interval content), as the normalized magnitude of TIV is subtracted from unity. This perceptually-inspired measure is based on the weighted magnitude of the TIV coefficients, ranging from 1 to 6 in the sense of Western tonal music to balance empirical dissonance scores.</span></p>
</li>
<li>
<p><strong><span>Chromaticity (chromatic):</span></strong><span> In a particular position of the chromatic pitch circle, chromaticity states the sonority concentration degree. This descriptor is computed as the magnitude of the first two dimensions of TIV normalized to unity. For sounds displaying energy, chromaticity is usually tonal chords and scales, this value is similar to 0 and near 1 for clusters.</span></p>
</li>
<li>
<p><strong><span>Dyadicity (dyad):</span></strong><span> It balances the half-octave frequency distribution and tests the weight of an influential tritone or fifth (in a more diatonic context). In non-tonal contexts, it has often been referred to as ‘quarter consistency’ because it is most significant for chords consisting of perfect and augmented fourths stacked. It is computed as the magnitude of the second pair of TIV dimensions normalized to unity.</span></p>
</li>
<li>
<p><strong><span>Triadicity (triad):</span></strong><span> For major and minor triads, this is the most important descriptor and has hence become and can be referred to as triadicity. In tonal contexts, it weighs a distribution position in a stack of major and minor thirds and may thus imply a weighting against a given key’s subdominant or dominant side. It suggests a resemblance to an augmented triad or hexatonic scale in non-tonal contexts. It is computed as the magnitude of the third dimensions pair of TIV normalized to unity.</span></p>
</li>
<li>
<p><strong><span>Diminished Quality (dim):</span></strong><span> This descriptor weights the three diminished seventh chords. It suggests octatonic in twentieth-century music. It is most potent for seventh chords in tonal contexts. It can also discern distributions by which the three harmonic functions are most predominant along the lines of a Riemannian or ‘axis’ scheme. It is computed as the magnitude fourth pair of TIV to unity.</span></p>
</li>
<li>
<p><strong><span>Diatonicity (diatonic):</span></strong><span> It states the degree of concentration of a sonority within the circle of fifths, and it ranges between 0 and 1. The greater the normalized fifth pair of TIV dimensions magnitude to unity, the higher the degree of diatonicity. It is computed as the magnitude of the fifth dimensions pair of the TIV normalized to unity.</span></p>
</li>
<li>
<p><strong><span>Whole toneness (wholeTone):</span></strong><span> It reports one of the two current whole-tone sets’ closeness. These two sets have been built inside the 12-tone equal temperament tuning. It is computed as the sixth pair of TIV dimensions magnitude normalized to unity and ranged from 0 to 1.</span></p>
</li>
<li>
<p><strong><span>Harmonic Change Detection Function (HCDF):</span></strong><span> This descriptor extract the harmonic changes of a piece. It is a continuous two dimensions function (time and HCDF magnitude). HCDF in each peak indicates a harmonic transition and the valley between two peaks notes the harmonic boundary.</span></p>
</li>
<li>
<p><strong><span>HCDF peaks:</span></strong><span> the HCDF magnitude on each piece harmonic change. This descriptor is computed from HCDF measuring the magnitude on each peak.</span></p>
</li>
<li>
<p><strong><span>Harmonic Rhythm (hRhythm):</span></strong><span> It is the time of each stable harmonic boundary. This descriptor is computed as the duration between the peaks.</span></p>
</li>
<li>
<p><strong><span>Tonal Dispersion (eucTDispersion and cosTDispersion):</span></strong><span> It measures the consonance (eucTDispersion) or the perceptual proximity (cosTDispersion) of each frame to the tonal center. Consonance is represented as the euclidean distance between two Tonal Interval Vectors. Due to the symmetry of the Tonal Interval Space, complementary intervals and transposition share the same level of consonance. Tonal center is computed as the mean of every TIV musical piece.</span></p>
</li>
<li>
<p><strong><span>Tonal Relatedness (eucTIV and cosTIV)</span></strong><span>: it measures the consonance (eucTIV) and perceptual proximity (cosTIV) progression frame by frame. Multi-resolution TIVs give significant comparisons of the harmonic time perspectives evolution.</span></p>
</li>
</ul><h2 id="Descriptors-Analysis" data-id="Descriptors-Analysis"><span>Descriptors Analysis</span></h2><p><span>For getting a better explanation of data have been applyed two techiques: Correlation matrix reductions and Feature selection.</span><br>
<span>[diagram dendogram of features]</span></p><p><strong><span>Correlation matrix reductions</span></strong><span>: This technique is used for watching the relationships between all the descriptors used. Clustering the correlation matrix by distance a dendogram is extracted to visualize how descritors are related, as is shown above.</span></p><p><span>[MDS of features]</span></p><p><strong><span>Feature importance:</span></strong><span> A cross validated logistic regression is performed to rank the importance of each feature to distinguis clasical music historical periods.</span><br>
<span>[feature selection rank graph]</span></p>
</section>

