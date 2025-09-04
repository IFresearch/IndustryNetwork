cd .\STCNA\3-Regression

use panel_data, clear


****************************************************************************************

*========== 原始模型（常规标准误） ==========
*m1-1: 周期+节点属性
xtlogit connection i.phases out_degree_diff in_degree_diff, or fe
scalar aic_m1_1 = -2*e(ll) + 2*e(k)
outreg2 using m1, replace tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p), "AIC", aic_m1_1) eform cti(odds ratio) tex

*m1-2: 周期+节点属性+控制变量
xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff, or fe
scalar aic_m1_2 = -2*e(ll) + 2*e(k)
outreg2 using m1, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p), "AIC", aic_m1_2) eform cti(odds ratio) tex

*m1-3
xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff, or fe
scalar aic_m1_3 = -2*e(ll) + 2*e(k)
outreg2 using m1, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p), "AIC", aic_m1_3) eform cti(odds ratio) tex

*m1-4
xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff mv_diff, or fe
scalar aic_m1_4 = -2*e(ll) + 2*e(k)
outreg2 using m1, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p), "AIC", aic_m1_4) eform cti(odds ratio) tex

*m1-5
xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff mv_diff alpha_diff, or fe
scalar aic_m1_5 = -2*e(ll) + 2*e(k)
outreg2 using m1, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p), "AIC", aic_m1_5) eform cti(odds ratio) tex

*m1-6
xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff mv_diff alpha_diff beta_dif, or fe
scalar aic_m1_6 = -2*e(ll) + 2*e(k)
outreg2 using m1, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p), "AIC", aic_m1_6) eform cti(odds ratio) tex

*========== Bootstrap稳健性检验 ==========
*m1-1-bootstrap: 周期+节点属性 (Bootstrap标准误)
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff, or fe
outreg2 using m1_bootstrap, replace tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m1-2-bootstrap: 周期+节点属性+控制变量 (Bootstrap标准误)
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff, or fe
outreg2 using m1_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m1-3-bootstrap
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff, or fe
outreg2 using m1_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m1-4-bootstrap
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff mv_diff, or fe
outreg2 using m1_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m1-5-bootstrap
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff mv_diff alpha_diff, or fe
outreg2 using m1_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m1-6-bootstrap
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff pe_diff dy_diff mv_diff alpha_diff beta_dif, or fe
outreg2 using m1_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex


***********************************************************************************************************

*========== 原始模型（常规标准误） ==========
*m2-1: 周期+ 节点属性+ 网络变量
xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering, or fe
outreg2 using m2, replace tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p),"AIC", aic_m2_1) eform cti(odds ratio) tex


*m2-2: 周期+ 节点属性+ 网络变量 + 控制变量(控制变量逐步引入)
xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff ,or fe
outreg2 using m2, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p),"AIC", aic_m2_2) eform cti(odds ratio) tex

*m2-3
xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff,or fe
outreg2 using m2, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p),"AIC", aic_m2_3) eform cti(odds ratio) tex

*m2-4
xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff mv_diff,or fe
outreg2 using m2, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p),"AIC", aic_m2_4) eform cti(odds ratio) tex

*m2-5
xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff,or fe
outreg2 using m2, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p),"AIC", aic_m2_5) eform cti(odds ratio) tex

*m2-6
xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff beta_dif,or fe
outreg2 using m2, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p),"AIC", aic_m2_6) eform cti(odds ratio) tex


*========== Bootstrap稳健性检验 ==========
*m2-1: 周期+ 节点属性+ 网络变量
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering, or fe
outreg2 using m2_bootstrap, replace tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex


*m2-2: 周期+ 节点属性+ 网络变量 + 控制变量(控制变量逐步引入)
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff ,or fe
outreg2 using m2_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m2-3
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff,or fe
outreg2 using m2_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m2-4
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff mv_diff,or fe
outreg2 using m2_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m2-5
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff,or fe
outreg2 using m2_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex

*m2-6
bootstrap, reps(100) seed(12345): xtlogit connection i.phases out_degree_diff in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff beta_dif,or fe
outreg2 using m2_bootstrap, append tstat bdec(3) tdec(2) addstat("Bootstrap reps", e(N_reps), "N observations", e(N), "N groups", e(N_g)) eform cti(odds ratio) tex


*********************************************************************************
* Nonlinear Model
*********************************************************************************

*m3 nonlinear with node-level

*m3-1
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff , or
outreg2 using nonlin_m3, replace tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex
 
*m3-2
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff pe_diff, or
outreg2 using nonlin_m3, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m3-3
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff  pe_diff dy_diff, or
outreg2 using nonlin_m3, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m3-4
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff  pe_diff dy_diff mv_diff, or
outreg2 using nonlin_m3, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m3-5
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff  pe_diff dy_diff mv_diff alpha_diff, or
outreg2 using nonlin_m3, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m3-6
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff  pe_diff dy_diff mv_diff alpha_diff, or
outreg2 using nonlin_m3, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m3-7
logit connection i.phases##c.out_degree_diff i.phases##c.in_degree_diff pe_diff dy_diff mv_diff alpha_diff beta_diff , or
outreg2 using nonlin_m3, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

************************************************
*m4 nonlinear with node-level and network-level
************************************************

*m4-1
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering, or
outreg2 using nonlin_m4, replace tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex
 
*m4-2
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff, or
outreg2 using nonlin_m4, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m4-3
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff, or
outreg2 using nonlin_m4, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m4-4
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff mv_diff, or
outreg2 using nonlin_m4, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m4-5
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff, or
outreg2 using nonlin_m4, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m4-6
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff, or
outreg2 using nonlin_m4, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m4-7
logit connection density average_clustering i.phases##c.out_degree_diff i.phases##c.in_degree_diff pe_diff dy_diff mv_diff alpha_diff beta_diff , or
outreg2 using nonlin_m4, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex


