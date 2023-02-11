import plotly.graph_objects as go
import plotly.express as px

def eigplot(X,Y):
    # fig = go.Figure(data=go.Scatter(
    #     x = X,y=Y,
    #     mode='markers',
    #     marker=dict(
    #         size=10,
    #         color=X,  # set color equal to a variable
    #         colorscale='Jet',  # one of plotly colorscales
    #         showscale=True
    #     )
    # ))
    # fig.show()
    #




    fig = px.scatter(x=X, y=Y)
    config = dict({'scrollZoom': True})
    fig.update_layout(dragmode='pan')
    fig.show(config=config)