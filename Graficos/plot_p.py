# coding: utf-8

import locale
# Set to German locale to get comma decimal separater
locale.setlocale(locale.LC_NUMERIC, "pt_BR.UTF-8")

import numpy as np
from matplotlib import pyplot as pt
import matplotlib.font_manager as font_manager
import matplotlib.ticker as tkr
from array import *
pt.rcParams['ytick.labelsize']='18'
pt.rc('font',family='Times New Roman')
pt.rc('mathtext',fontset='stix')

#valores de entrada
v = 1.3568
d = 34.83e-3
rho_exp = 1.1562164488

#lendo valores experimentais
A = np.loadtxt('Experimental')
x_exp = A[:,0]
c = len(A[:,2])
p_adm_last = A[c-1,2]	#último valor do vetor
p_adm_exp = A[:,2]
c = len(A[:,1])
p_dim_last = A[c-1,1]
p_dim_exp = A[:,1]

#lendo arquivo do OpenFoam e separação das variáveis
A = np.loadtxt('../Laminar/postProcessing/sampleDict/2000/reed_p.xy')
x_lam = A[:,0]
x_lam = x_lam/d
p_lam = A[:,1]
p_adm_lam = 2.*p_lam/(v**2)	#adimensionalizando a pressao
p_adm_lam = p_adm_lam + float(p_adm_last)
p_dim_lam = p_lam*rho_exp
p_dim_lam = p_dim_lam + float(p_dim_last)

#lendo arquivo do OpenFoam e separação das variáveis
A = np.loadtxt('../SST/postProcessing/sampleDict/2000/reed_p.xy')
x_sst = A[:,0]
x_sst = x_sst/d
p_sst = A[:,1]
p_adm_sst = 2.*p_sst/(v**2)	#adimensionalizando a pressao
p_adm_sst = p_adm_sst + float(p_adm_last)
p_dim_sst = p_sst*rho_exp
p_dim_sst = p_dim_sst + float(p_dim_last)

#lendo arquivo do OpenFoam e separação das variáveis
A = np.loadtxt('../RNG/postProcessing/sampleDict/2000/reed_p.xy')
x_rng = A[:,0]
x_rng = x_rng/d
p_rng = A[:,1]
p_adm_rng = 2.*p_rng/(v**2)	#adimensionalizando a pressao
p_adm_rng = p_adm_rng + float(p_adm_last)
p_dim_rng = p_rng*rho_exp
p_dim_rng = p_dim_rng + float(p_dim_last)


# Tell matplotlib to use the locale we set above
pt.rcParams['axes.formatter.use_locale'] = True

#fig1=pt.figure()
pt.figure(num=None, figsize=(10, 10)) #define as dimensões da imagem produzida
#pt.title("D/d = 1.5   -   Re = 2,987   -   s/d = 0.03", fontsize=20)
#pt.xlim(0,0.8) #intervalo dos valores máximo e mínimo do eixo x
#pt.ylim(-5,30) #intervalo dos valores máximo e mínimo do eixo y
#Setting linestyles
linestyles = ['-', '--', ':', '-.', '-,','-..']
pt.plot(x_sst, p_dim_sst, linestyles[0],  linewidth=3, label=u'$k\omega$ SST')
pt.plot(x_rng, p_dim_rng, linestyles[1],  linewidth=3, label=u'RNG $k\epsilon$')
pt.plot(x_lam, p_dim_lam, linestyles[2],  linewidth=3, label=u'Laminar')
pt.plot(x_exp,p_dim_exp, marker='o', mfc='none', mec='black', mew=1,  markersize=7, linestyle='',label=u'Experimental')
pt.tick_params(axis='x', labelsize=20)
pt.tick_params(axis='y', labelsize=20)
pt.legend(fontsize=18)
pt.xlabel('r/d', fontsize=22) 
pt.ylabel('p [Pa]', fontsize=22)
pt.axhline(0, color='black')
pt.axvline(0, color='black')
pt.savefig('Perfil-pressao' + '.png')
pt.show()


