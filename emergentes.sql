PGDMP     2                    |            tecnologias    15.3    15.3 #               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                        1262    16446    tecnologias    DATABASE     �   CREATE DATABASE tecnologias WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Bolivia.1252';
    DROP DATABASE tecnologias;
                postgres    false            �            1259    16447    clientes    TABLE     �   CREATE TABLE public.clientes (
    clienteid integer NOT NULL,
    usuario character varying(100),
    "contraseña" character varying(100)
);
    DROP TABLE public.clientes;
       public         heap    postgres    false            �            1259    16450    clientes_clienteid_seq    SEQUENCE     �   CREATE SEQUENCE public.clientes_clienteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.clientes_clienteid_seq;
       public          postgres    false    214            !           0    0    clientes_clienteid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.clientes_clienteid_seq OWNED BY public.clientes.clienteid;
          public          postgres    false    215            �            1259    16451    detallespedido    TABLE     �   CREATE TABLE public.detallespedido (
    detalleid integer NOT NULL,
    pedidoid integer,
    productoid integer,
    cantidad integer NOT NULL,
    preciounitario numeric(10,2) NOT NULL
);
 "   DROP TABLE public.detallespedido;
       public         heap    postgres    false            �            1259    16454    detallespedido_detalleid_seq    SEQUENCE     �   CREATE SEQUENCE public.detallespedido_detalleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.detallespedido_detalleid_seq;
       public          postgres    false    216            "           0    0    detallespedido_detalleid_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.detallespedido_detalleid_seq OWNED BY public.detallespedido.detalleid;
          public          postgres    false    217            �            1259    16455    pedidos    TABLE     .  CREATE TABLE public.pedidos (
    pedidoid integer NOT NULL,
    clienteid integer,
    direccion character varying(255) NOT NULL,
    fechapedido timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total numeric(10,2),
    estado character varying(50) DEFAULT 'Pendiente'::character varying
);
    DROP TABLE public.pedidos;
       public         heap    postgres    false            �            1259    16460    pedidos_pedidoid_seq    SEQUENCE     �   CREATE SEQUENCE public.pedidos_pedidoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pedidos_pedidoid_seq;
       public          postgres    false    218            #           0    0    pedidos_pedidoid_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.pedidos_pedidoid_seq OWNED BY public.pedidos.pedidoid;
          public          postgres    false    219            �            1259    16461 	   productos    TABLE     �   CREATE TABLE public.productos (
    productoid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    precio integer NOT NULL,
    categoriaid character varying(2) NOT NULL,
    stock integer
);
    DROP TABLE public.productos;
       public         heap    postgres    false            �            1259    16466    productos_productoid_seq    SEQUENCE     �   CREATE SEQUENCE public.productos_productoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.productos_productoid_seq;
       public          postgres    false    220            $           0    0    productos_productoid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.productos_productoid_seq OWNED BY public.productos.productoid;
          public          postgres    false    221            t           2604    16467    clientes clienteid    DEFAULT     x   ALTER TABLE ONLY public.clientes ALTER COLUMN clienteid SET DEFAULT nextval('public.clientes_clienteid_seq'::regclass);
 A   ALTER TABLE public.clientes ALTER COLUMN clienteid DROP DEFAULT;
       public          postgres    false    215    214            u           2604    16468    detallespedido detalleid    DEFAULT     �   ALTER TABLE ONLY public.detallespedido ALTER COLUMN detalleid SET DEFAULT nextval('public.detallespedido_detalleid_seq'::regclass);
 G   ALTER TABLE public.detallespedido ALTER COLUMN detalleid DROP DEFAULT;
       public          postgres    false    217    216            v           2604    16469    pedidos pedidoid    DEFAULT     t   ALTER TABLE ONLY public.pedidos ALTER COLUMN pedidoid SET DEFAULT nextval('public.pedidos_pedidoid_seq'::regclass);
 ?   ALTER TABLE public.pedidos ALTER COLUMN pedidoid DROP DEFAULT;
       public          postgres    false    219    218            y           2604    16470    productos productoid    DEFAULT     |   ALTER TABLE ONLY public.productos ALTER COLUMN productoid SET DEFAULT nextval('public.productos_productoid_seq'::regclass);
 C   ALTER TABLE public.productos ALTER COLUMN productoid DROP DEFAULT;
       public          postgres    false    221    220                      0    16447    clientes 
   TABLE DATA           E   COPY public.clientes (clienteid, usuario, "contraseña") FROM stdin;
    public          postgres    false    214   �(                 0    16451    detallespedido 
   TABLE DATA           c   COPY public.detallespedido (detalleid, pedidoid, productoid, cantidad, preciounitario) FROM stdin;
    public          postgres    false    216   �)                 0    16455    pedidos 
   TABLE DATA           ]   COPY public.pedidos (pedidoid, clienteid, direccion, fechapedido, total, estado) FROM stdin;
    public          postgres    false    218   �)                 0    16461 	   productos 
   TABLE DATA           `   COPY public.productos (productoid, nombre, descripcion, precio, categoriaid, stock) FROM stdin;
    public          postgres    false    220   H+       %           0    0    clientes_clienteid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.clientes_clienteid_seq', 9, true);
          public          postgres    false    215            &           0    0    detallespedido_detalleid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.detallespedido_detalleid_seq', 8, true);
          public          postgres    false    217            '           0    0    pedidos_pedidoid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.pedidos_pedidoid_seq', 10, true);
          public          postgres    false    219            (           0    0    productos_productoid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.productos_productoid_seq', 25, true);
          public          postgres    false    221            {           2606    16472    clientes clientes_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (clienteid);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    214            }           2606    16474 "   detallespedido detallespedido_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.detallespedido
    ADD CONSTRAINT detallespedido_pkey PRIMARY KEY (detalleid);
 L   ALTER TABLE ONLY public.detallespedido DROP CONSTRAINT detallespedido_pkey;
       public            postgres    false    216                       2606    16476    pedidos pedidos_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (pedidoid);
 >   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_pkey;
       public            postgres    false    218            �           2606    16478    productos productos_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (productoid);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    220            �           2606    16479 +   detallespedido detallespedido_pedidoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallespedido
    ADD CONSTRAINT detallespedido_pedidoid_fkey FOREIGN KEY (pedidoid) REFERENCES public.pedidos(pedidoid);
 U   ALTER TABLE ONLY public.detallespedido DROP CONSTRAINT detallespedido_pedidoid_fkey;
       public          postgres    false    3199    218    216            �           2606    16484 -   detallespedido detallespedido_productoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallespedido
    ADD CONSTRAINT detallespedido_productoid_fkey FOREIGN KEY (productoid) REFERENCES public.productos(productoid);
 W   ALTER TABLE ONLY public.detallespedido DROP CONSTRAINT detallespedido_productoid_fkey;
       public          postgres    false    220    216    3201            �           2606    16489    pedidos pedidos_clienteid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_clienteid_fkey FOREIGN KEY (clienteid) REFERENCES public.clientes(clienteid);
 H   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_clienteid_fkey;
       public          postgres    false    3195    218    214               ~   x�U�I
�0еt�R;c�R0�Q�K< Ǜ��J0����&�J�e�B�R��z�@�ܚ��V����%R\�0b/���IZįU�L3�U_\�����ϟ~��L��3dփW~ o~�@��yC�S(7S         E   x�M��  �0�Aq���ç�^�4��e��"�,�p�RV�h +9�a~�ƔB�A��=�*�`�(�A         ]  x���Mj�0F��)� �ѿd��]uQ�՞�"�6�X=C/V9�&ۀ�f���Ì0Ҹ�]8:`\<@���u�&�r��zE0Z���h��&�ץ�N�F�9�z�z�w?90�/��Ƴ�'��'�+��c�D�MN��C������|K�js�
`��j�2zQy^�� ���j�<^(���)?S\l1�EԲ������Ӆ���se���:�ޞ�|b��.�e��9��0%����H��,�;�ػ C�w	���|��v����)�7�}�B���Obj�j�J��5��+�������VV�Iu'��5W%�FU�F���,�߷�Hmn,eQ�@��         �  x�m�MN�0���)|Ԥ�K�@������3$�.�]TnÒ%���J���H���̛gl/ȅ�\�h�=߳r�
��Jb����&������t��ij-tu�ь��$R2�Bނ�-�\x�����2W�:�`Ŷ`�#��'��I`Q�k�;��;IF�6+&l���7�w`��Wƾ�8b�,@�hQ�&1�8�8�L8B)r;41gk��a9%)���ՇM�l��5?��6z��/�!]$��^^�ִphwY{5ܙ6'H�c��3�AE�Ђ���b�$�t�ᄒ��<��(ڪ�˅9Ǩ�e������X~�+)��؇n%)&�5�52{m�R�QK�������G�m|׹��
�u���I��՚^K�&���h��4�b     