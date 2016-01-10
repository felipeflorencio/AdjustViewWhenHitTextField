#AdjustViewWhenHitTextField

[link]### <a name="pt_br"></a>Portuguese BR Tutorial!

(#english)
# Description, Why?
Easy description of how adjust views that has UITextField and when keyboard show up text field stayed behind keyboard.
This tutorial its just a simple example that how we make view scroll up and back to original state after keyboard show and the tapped UITextField stayed behind keyboard.

That could be applied for any object that of kind UIView, for example: UILabel, UIButton.

#Tutorial

Download project and see how we created or view, most important to know is, the right way in this case is use UIScrollView, that because if we handle with our UIView some weird situations, like a black view behind happens.   

#Code
First at viewDidLoad method insert this notifications

```objective-c
// Set observer for receive keyboard notifications
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardWasShown:)
                                             name:UIKeyboardDidShowNotification
                                           object:nil];

[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardWillBeHidden:)
                                             name:UIKeyboardWillHideNotification
                                           object:nil];

[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(userTappedOnField:)
                                             name:UITextFieldTextDidBeginEditingNotification
                                           object:nil];
```

Now we will create methods that will be called when keyboard will show up and dismiss

```objective-c
// View readjust actions
- (void)keyboardWasShown:(NSNotification *)notification {

    NSDictionary* info = [notification userInfo];

    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGPoint txtFieldView = _selectedField.frame.origin;

    CGFloat txtFieldViewHeight = _selectedField.frame.size.height;

    CGRect visibleRect = self.viewInsideScroll.frame;

    visibleRect.size.height -= keyboardSize.height;

    if (!CGRectContainsPoint(visibleRect, txtFieldView)){

        CGPoint scrollPoint = CGPointMake(0.0, txtFieldView.y - visibleRect.size.height + (txtFieldViewHeight * 1.5));

        [self.scrollView setContentOffset:scrollPoint animated:YES];

    }

}

- (void)keyboardWillBeHidden:(NSNotification *)notification {

    [self.scrollView setContentOffset:CGPointZero animated:YES];

}
```

Now you will see that we are getting our field size, and for that i created a helper method that will "save" which UITextField was select for we get size and other informations.

First create a property in our interface:
```objective-c
@property (nonatomic, strong) UITextField *selectedField;
```

Now create the method that will receive UITextfield notification, we already attached notification at viewDidLoad:
```objective-c


- (void)userTappedOnField:(NSNotification*)txtSelected{

    if ([txtSelected.object isKindOfClass:UITextField.class]){
        _selectedField = txtSelected.object;
    }

}

```

Now its done, download or project to see finished, has one or other helper, but with just this code everything was fine.

#Tip

If you don't want handle all this thinks just use a UITableView, when your view is inside UITableView, the table view will handle this scroll situation without any other implementation.

### <a name="english"></a>Go to top.

[link](#pt_br)
# Description, Why?
Simples demonstração de como reajustar um UIView quando temos nela um ou vários UITextField e ao selecionar e o teclado subir ou esconder nos garantimos que o UITextField não irá ficar atrás do teclado.

Esse conceito pode ser aplicado para qualquer objeto to tipo UIView, por exemplo: UILabel, UIbutton.

#Tutorial

Faça o download / fork do projeto e veja como criamos nossa view, o mais importante a saber, é que a maneira correta nesse caso é usando uma UIScrollView, isso porquê se alterarmos direto nossa UIView poderá acontecer algumas situações estranhas, como uma "view" preta no fundo.

#Código
Primeito no método viewDidLoad insira essa notificações

```objective-c
// Set observer for receive keyboard notifications
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardWasShown:)
                                             name:UIKeyboardDidShowNotification
                                           object:nil];

[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardWillBeHidden:)
                                             name:UIKeyboardWillHideNotification
                                           object:nil];

[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(userTappedOnField:)
                                             name:UITextFieldTextDidBeginEditingNotification
                                           object:nil];
```

Agora nós vamos criar os métodos que irão lidar com o teclado quando ele subir e descer.

```objective-c
// View readjust actions
- (void)keyboardWasShown:(NSNotification *)notification {

    NSDictionary* info = [notification userInfo];

    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGPoint txtFieldView = _selectedField.frame.origin;

    CGFloat txtFieldViewHeight = _selectedField.frame.size.height;

    CGRect visibleRect = self.viewInsideScroll.frame;

    visibleRect.size.height -= keyboardSize.height;

    if (!CGRectContainsPoint(visibleRect, txtFieldView)){

        CGPoint scrollPoint = CGPointMake(0.0, txtFieldView.y - visibleRect.size.height + (txtFieldViewHeight * 1.5));

        [self.scrollView setContentOffset:scrollPoint animated:YES];

    }

}

- (void)keyboardWillBeHidden:(NSNotification *)notification {

    [self.scrollView setContentOffset:CGPointZero animated:YES];

}
```

Agora você irá ver que estamos pegando a UITextField selecionada, e para isso eu criei um método de auxílio que "salva" qual UITextField foi selecionado para poder pegar o tamanos e outras informações.

Primeiro crie uma propriedade na nossa interface:
```objective-c
@property (nonatomic, strong) UITextField *selectedField;
```
Agora crie o método que irá receber os eventos de clique no nosso UITextField, nós inserimos essa notificação no nosso viewDidLoad:

```objective-c


- (void)userTappedOnField:(NSNotification*)txtSelected{

    if ([txtSelected.object isKindOfClass:UITextField.class]){
        _selectedField = txtSelected.object;
    }

}

```
Agora esta pronto, faça download do projeto terminado, tem mais um ou dois itens de auxílio lá, mas somente com o código aqui demonstrado esta completo.

#Dica

Se você não quer lidar com todas essa notificações, é simples, é só usar um UITableView. Quando sua view esta dentro de uma UITableView, a table view irá lidar com todas essas situações de scroll sem nenhuma implementação.

### <a name="english"></a>Subir.
