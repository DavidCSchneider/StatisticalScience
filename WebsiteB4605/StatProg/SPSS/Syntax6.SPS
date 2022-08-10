UNIANOVA
  number  BY treatmen time
  /CONTRAST (treatmen)=Simple /CONTRAST (time)=Simple
  /METHOD = SSTYPE(3)
  /INTERCEPT = EXCLUDE
  /SAVE = PRED RESID
  /PRINT = DESCRIPTIVE OPOWER
  /PLOT = RESIDUALS
  /CRITERIA = ALPHA(.05)
  /DESIGN = treatmen time time*treatmen .
