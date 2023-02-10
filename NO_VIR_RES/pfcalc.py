import numpy as np
from numpy import linalg as la
from numpy.linalg import inv
import plotly.express as px


def pfcalc(A):
    eigs = la.eig(A)
    x_labels = np.round(eigs[0], 3)
    x_labels = x_labels.astype('U25')
    y_labels = np.arange(0, len(eigs[0]), 1)
    P = (eigs[1])
    QT = inv(P)

    Q = QT.transpose()

    pf = np.zeros(np.shape(A), dtype = 'complex_')
    j = 0

    # j is index on columns (modes)
    # i is index on rows (states)

    while j < len(eigs[0]):
        i = 0
        while i < len(eigs[0]):
            pf[i, j] = Q[i, j]*P[i, j]
            i = i + 1

        j = j + 1
    # print(pf)
    pfabs = np.abs(pf)
    pfabs = np.round(pfabs,1)
    fig = px.imshow(pfabs, color_continuous_scale = 'Jet',
                    labels=dict(x="Eigenvalues", y="State Number", color="Participation"),
                    x=x_labels,
                    y=y_labels
                    )
    # config = dict({'scrollZoom': True})
    # fig.update_layout(dragmode='pan')
    # fig.show(config=config)
    fig.show()

